import 'package:fidelyn_user_app/app/app_module.dart';
import 'package:fidelyn_user_app/app/app_widget.dart';
import 'package:fidelyn_user_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await dotenv.load(fileName: ".env");

  Modular.setInitialRoute('/splash');

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
