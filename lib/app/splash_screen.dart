import 'package:fidelin_user_app/app/core/stores/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key}) {
    Modular.get<AppStore>().check().then((v) {
      return Future.delayed(const Duration(seconds: 2));
    }).then((value) {
      Modular.to.pushNamedAndRemoveUntil("/home/", (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
