import 'package:fidelin_user_app/app/app_module.dart';
import 'package:fidelin_user_app/app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
