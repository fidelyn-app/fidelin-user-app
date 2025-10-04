// lib/env.dart
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
}
