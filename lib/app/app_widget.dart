import 'package:asuka/asuka.dart';
import 'package:fidelin_user_app/utils/buttons_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFF22F52);

    final primaryButtonStyle = ElevatedButton.styleFrom(
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      foregroundColor: Colors.white, // 🟢 COR DO TEXTO / ÍCONE
      backgroundColor: const Color(0xFFF22F52), // 🔴 COR DE FUNDO
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    );

    final secondaryButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: primaryColor, // texto/ícone vermelho
      backgroundColor: Colors.white, // fundo branco
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: primaryColor, width: 2), // borda vermelha
      ),
      elevation: 0,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
    return MaterialApp.router(
      builder: Asuka.builder,
      title: 'Fidelyn User',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF22F52),
          primary: const Color(0xFFF22F52),
          secondary: const Color(0xFF082359),
          tertiary: const Color(0xFFAC243D),
          brightness: Brightness.light,
          surface: const Color(0xFFFFFFFF),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Color(0xFFF22F52)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButtonStyle),
        extensions: <ThemeExtension<dynamic>>[
          AppButtonStyles(
            primary: primaryButtonStyle,
            secondary: secondaryButtonStyle,
          ),
        ],
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
