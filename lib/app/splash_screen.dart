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
    // mesma cor da splash nativa (use exatamente o hex)
    const bgColor = Color(0xFFF22F52);

    final width = MediaQuery.of(context).size.width;

    // ajuste a porcentagem (0.20 a 0.30 geralmente funciona bem)
    final logoSize = width * 0.70;

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Image.asset(
          'assets/app/splash-screen.png',
          fit: BoxFit.fill,
          width: logoSize,
          // se a sua imagem tiver fundo transparente, é ok;
          // se quiser, force um fundo com Container/Decoration antes do ClipOval.
        ),
      ),
    );
  }
}
