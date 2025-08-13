# scripts/bump.py
# Executar: python3 scripts/bump.py
import os
import re
import sys
import pathlib
import subprocess
import datetime

repo_root = pathlib.Path(__file__).resolve().parent.parent

# Inputs via environment (workflow irá setar)
pr_title = os.getenv('PR_TITLE', '') or ''
pr_body = os.getenv('PR_BODY', '') or ''
pr_number = os.getenv('PR_NUMBER', '') or ''
pr_user = os.getenv('PR_USER', '') or ''
github_token = os.getenv('GITHUB_TOKEN', '')
# Detect bump type from PR title if not explicitly passed
bump = os.getenv('BUMP_TYPE', '') or ''

if not bump:
    m = re.search(r'\[(major|minor|patch|build)\]', pr_title, flags=re.I)
    if not m:
        m = re.search(r'^(major|minor|patch|build)[:\s\-]', pr_title, flags=re.I)
    if not m:
        m = re.search(r'\b(major|minor|patch|build)\b', pr_title, flags=re.I)
    if m:
        bump = m.group(1).lower()
    else:
        bump = 'none'

if bump not in ('major', 'minor', 'patch', 'build'):
    print("No bump requested (no [MAJOR]/[MINOR]/[PATCH]/[BUILD] in PR title). Exiting.")
    sys.exit(0)

print("Detected bump type:", bump)

# --- pubspec.yaml ---
pubspec_path = repo_root / 'pubspec.yaml'
if not pubspec_path.exists():
    print("Error: pubspec.yaml not found at", pubspec_path)
    sys.exit(1)

txt = pubspec_path.read_text(encoding='utf-8')
m = re.search(r'^\s*version:\s*([0-9]+)\.([0-9]+)\.([0-9]+)(?:\+([0-9]+))?\s*$',
              txt, flags=re.MULTILINE)
if not m:
    print("Could not find 'version: X.Y.Z+N' in pubspec.yaml")
    sys.exit(1)

major, minor, patch, build = m.groups()
major = int(major)
minor = int(minor)
patch = int(patch)
build = int(build) if build else 0

old_version = f"{major}.{minor}.{patch}"
old_build = build
print("Old version:", old_version, "Old build:", old_build)

# Bump logic
if bump == 'major':
    major += 1
    minor = 0
    patch = 0
elif bump == 'minor':
    minor += 1
    patch = 0
elif bump == 'patch':
    patch += 1
elif bump == 'build':
    # keep semver, only increase build
    pass

new_build = old_build + 1
new_version = f"{major}.{minor}.{patch}"
new_version_line = f"version: {new_version}+{new_build}"

# Write pubspec
txt2 = re.sub(r'^\s*version:.*$', new_version_line, txt, flags=re.MULTILINE)
pubspec_path.write_text(txt2, encoding='utf-8')
print("Wrote new pubspec version:", new_version_line)

# --- Android: try build.gradle or build.gradle.kts ---
android_gradle = repo_root / 'android' / 'app' / 'build.gradle'
android_gradle_kts = repo_root / 'android' / 'app' / 'build.gradle.kts'
android_file = None
if android_gradle.exists():
    android_file = android_gradle
elif android_gradle_kts.exists():
    android_file = android_gradle_kts

if android_file:
    gtxt = android_file.read_text(encoding='utf-8')
    # update versionCode (handles both "versionCode 1" and "versionCode = 1")
    gtxt2 = re.sub(r'(versionCode\s*=?\s*)(\d+)', lambda m: m.group(1) + str(new_build), gtxt)
    # update versionName (handles both 'versionName "x.y.z"' and 'versionName = "x.y.z"')
    gtxt2 = re.sub(r'(versionName\s*=?\s*)"[^"]+"', lambda m: m.group(1) + f'"{new_version}"', gtxt2)
    if gtxt != gtxt2:
        android_file.write_text(gtxt2, encoding='utf-8')
        print(f"Updated {android_file.relative_to(repo_root)} -> versionCode and versionName")
    else:
        print(f"No changes in {android_file.relative_to(repo_root)} (patterns not found).")
else:
    print("android/app/build.gradle(.kts) not found; skipping Android update.")

# --- iOS (ios/Runner/Info.plist) ---
ios_info = repo_root / 'ios' / 'Runner' / 'Info.plist'
if ios_info.exists():
    itxt = ios_info.read_text(encoding='utf-8')
    # use lambda replacements to avoid backreference ambiguity (\1 + digits)
    itxt2 = re.sub(
        r'(<key>CFBundleShortVersionString</key>\s*<string>)([^<]+)(</string>)',
        lambda m: m.group(1) + new_version + m.group(3),
        itxt,
        flags=re.MULTILINE
    )
    itxt2 = re.sub(
        r'(<key>CFBundleVersion</key>\s*<string>)([^<]+)(</string>)',
        lambda m: m.group(1) + str(new_build) + m.group(3),
        itxt2,
        flags=re.MULTILINE
    )
    if itxt != itxt2:
        ios_info.write_text(itxt2, encoding='utf-8')
        print("Updated ios/Runner/Info.plist -> CFBundleShortVersionString and CFBundleVersion")
    else:
        print("No changes in ios/Runner/Info.plist (patterns not found).")
else:
    print("ios/Runner/Info.plist not found; skipping iOS update.")

# --- CHANGELOG.md entry ---
changelog_path = repo_root / 'CHANGELOG.md'
today = datetime.datetime.utcnow().date().isoformat()
tag_name = f"v{new_version}+{new_build}"

header = f"## {tag_name} - {today}\n\n"
meta = f"- PR #{pr_number} by @{pr_user}\n- Title: {pr_title}\n\n"
body = (pr_body.strip() + "\n\n") if pr_body.strip() else ""
entry = header + meta + body + "---\n\n"

if changelog_path.exists():
    existing = changelog_path.read_text(encoding='utf-8')
    changelog_path.write_text(entry + existing, encoding='utf-8')
    print("Prepended changelog with PR description.")
else:
    changelog_path.write_text("# Changelog\n\n" + entry, encoding='utf-8')
    print("Created CHANGELOG.md with first entry.")

# --- Git commit, tag, push ---
# Ensure git user
subprocess.run(['git', 'config', 'user.name', 'github-actions'], check=True)
subprocess.run(['git', 'config', 'user.email', 'actions@github.com'], check=True)

subprocess.run(['git', 'add', '-A'], check=True)
commit_msg = f'chore: bump version to {new_version}+{new_build} (BUMP={bump}) - PR #{pr_number} [ci skip]'
res = subprocess.run(['git', 'status', '--porcelain'], capture_output=True, text=True)
if not res.stdout.strip():
    print("No changes to commit.")
    sys.exit(0)

subprocess.run(['git', 'commit', '-m', commit_msg], check=True)

# Create tag
tag_msg = f"{tag_name} - Release generated by workflow (PR #{pr_number})"
subprocess.run(['git', 'tag', '-a', tag_name, '-m', tag_msg], check=True)

# Push commit and tag
# Note: actions/checkout must be used with persist-credentials: true so this push uses the GITHUB_TOKEN.
subprocess.run(['git', 'push', 'origin', 'HEAD:main'], check=True)
subprocess.run(['git', 'push', 'origin', tag_name], check=True)

print("Committed, pushed and tagged:", tag_name)
