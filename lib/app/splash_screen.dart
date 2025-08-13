import 'package:fidelin_user_app/app/core/stores/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key}) {
    Modular.get<AppStore>()
        .check()
        .then((v) {
          return Future.delayed(const Duration(seconds: 2));
        })
        .then((value) {
          Modular.to.pushNamedAndRemoveUntil("/home/", (_) => false);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF22F52), // cor vermelha da splash nativa
      body: Center(
        child: Image.asset(
          'assets/app/splash-screen.png',
          width: 125,
          height: 125,
        ),
      ),
    );
  }
}
