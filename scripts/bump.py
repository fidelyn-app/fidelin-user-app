#!/usr/bin/env python3
import os
import re
import subprocess
from pathlib import Path
from datetime import datetime

# -------------------------
# Configurações
# -------------------------
PUBSPEC_FILE = Path("pubspec.yaml")
IOS_INFO_PLIST = Path("ios/Runner/Info.plist")
ANDROID_GRADLE_FILES = [
    Path("android/app/build.gradle.kts"),
    Path("android/app/build.gradle")
]
CHANGELOG_FILE = Path("CHANGELOG.md")

# -------------------------
# Funções auxiliares
# -------------------------

def read_version_from_pubspec():
    content = PUBSPEC_FILE.read_text()
    match = re.search(r"version:\s*([0-9]+\.[0-9]+\.[0-9]+)\+([0-9]+)", content)
    if not match:
        raise ValueError("Não foi possível encontrar a versão no pubspec.yaml")
    return match.group(1), int(match.group(2))

def write_version_to_pubspec(version, build):
    content = PUBSPEC_FILE.read_text()
    content = re.sub(r"version:\s*[0-9]+\.[0-9]+\.[0-9]+\+([0-9]+)",
                     f"version: {version}+{build}", content)
    PUBSPEC_FILE.write_text(content)

def bump_version(version, bump_type):
    major, minor, patch = map(int, version.split('.'))
    if bump_type == "major":
        major += 1
        minor = 0
        patch = 0
    elif bump_type == "minor":
        minor += 1
        patch = 0
    elif bump_type == "patch":
        patch += 1
    else:
        raise ValueError("Bump type inválido")
    return f"{major}.{minor}.{patch}"

def update_ios_info_plist(version, build):
    if IOS_INFO_PLIST.exists():
        text = IOS_INFO_PLIST.read_text()
        text = re.sub(r"<key>CFBundleShortVersionString</key>\s*<string>[^<]+</string>",
                      f"<key>CFBundleShortVersionString</key>\n\t<string>{version}</string>", text)
        text = re.sub(r"<key>CFBundleVersion</key>\s*<string>[^<]+</string>",
                      f"<key>CFBundleVersion</key>\n\t<string>{build}</string>", text)
        IOS_INFO_PLIST.write_text(text)
        print("Atualizado ios/Runner/Info.plist -> CFBundleShortVersionString e CFBundleVersion")
    else:
        print("Info.plist não encontrado; pulando atualização iOS.")

def update_android_gradle(version, build):
    for gradle_file in ANDROID_GRADLE_FILES:
        if gradle_file.exists():
            text = gradle_file.read_text()
            
            # Se usar variáveis do Flutter, não mexe
            if "flutter.versionCode" in text and "flutter.versionName" in text:
                print(f"{gradle_file} usa flutter.versionCode/versionName; sem alterações necessárias.")
                continue
            
            # Atualiza valores fixos
            new_text = re.sub(r"versionCode\s+\d+", f"versionCode {build}", text)
            new_text = re.sub(r'versionName\s+"[^"]+"', f'versionName "{version}"', new_text)
            
            if new_text != text:
                gradle_file.write_text(new_text)
                print(f"Atualizado {gradle_file} -> versionCode e versionName")
            else:
                print(f"Nenhuma alteração necessária em {gradle_file}")

def update_changelog(version, build, bump_type, pr_number):
    now = datetime.now().strftime("%Y-%m-%d")
    entry = f"## {version}+{build} - {now}\n- Bump type: {bump_type} (PR #{pr_number})\n\n"
    if CHANGELOG_FILE.exists():
        old_content = CHANGELOG_FILE.read_text()
    else:
        old_content = ""
    CHANGELOG_FILE.write_text(entry + old_content)
    print("CHANGELOG.md atualizado.")

def safe_git_commit(commit_msg):
    # Configura Git caso não esteja configurado (CI)
    try:
        subprocess.run(["git", "config", "--global", "user.name"], check=True, capture_output=True)
        subprocess.run(["git", "config", "--global", "user.email"], check=True, capture_output=True)
    except subprocess.CalledProcessError:
        subprocess.run(["git", "config", "--global", "user.name", "github-actions[bot]"], check=True)
        subprocess.run(["git", "config", "--global", "user.email", "github-actions[bot]@users.noreply.github.com"], check=True)

    subprocess.run(["git", "add", "."], check=True)
    subprocess.run(["git", "commit", "-m", commit_msg], check=True)

def safe_git_push(tag_name):
    subprocess.run(["git", "push", "origin", "HEAD:main"], check=True)
    subprocess.run(["git", "push", "origin", tag_name], check=True)

# -------------------------
# Execução principal
# -------------------------

if __name__ == "__main__":
    # -------------------------
    # Detect bump type
    # -------------------------
    bump_type = os.getenv("BUMP_TYPE")
    if not bump_type:
        pr_title = os.getenv("PR_TITLE", "")
        if "[MAJOR]" in pr_title.upper():
            bump_type = "major"
        elif "[MINOR]" in pr_title.upper():
            bump_type = "minor"
        elif "[PATCH]" in pr_title.upper():
            bump_type = "patch"
        else:
            bump_type = "patch"  # default
    bump_type = bump_type.lower()

    pr_number = os.getenv("PR_NUMBER", "manual")

    old_version, old_build = read_version_from_pubspec()
    new_version = bump_version(old_version, bump_type)
    new_build = old_build + 1

    print(f"Detected bump type: {bump_type}")
    print(f"Old version: {old_version} Old build: {old_build}")
    print(f"New version: {new_version}+{new_build}")

    write_version_to_pubspec(new_version, new_build)
    update_ios_info_plist(new_version, new_build)
    update_android_gradle(new_version, new_build)
    update_changelog(new_version, new_build, bump_type, pr_number)

    # Commit e tag com segurança
    commit_msg = f"chore: bump version to {new_version}+{new_build} (BUMP={bump_type}) - PR #{pr_number} [ci skip]"
    safe_git_commit(commit_msg)

    tag_name = f"v{new_version}+{new_build}"
    subprocess.run(["git", "tag", tag_name], check=True)
    safe_git_push(tag_name)

    print(f"Version bumped and pushed: {new_version}+{new_build}")
