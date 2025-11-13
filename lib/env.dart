import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get flavor {
    const f = String.fromEnvironment('FLAVOR');
    if (f.isNotEmpty) return f;
    return dotenv.env['FLAVOR'] ?? 'production';
  }

  static String get configCatKey {
    const k = String.fromEnvironment('CONFIGCAT_SDK_KEY');
    if (k.isNotEmpty) return k;
    return dotenv.env['CONFIGCAT_SDK_KEY'] ?? '';
  }

  static String get baseUrl {
    const b = String.fromEnvironment('BASE_URL');
    if (b.isNotEmpty) return b;
    return dotenv.env['BASE_URL'] ?? '';
  }

  static String get googleOauthKey {
    const g = String.fromEnvironment('GOOGLE_OAUTH_KEY');
    if (g.isNotEmpty) return g;
    return dotenv.env['GOOGLE_OAUTH_KEY'] ?? '';
  }
}
