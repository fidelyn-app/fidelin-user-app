import 'package:fidelyn_user_app/app/core/stores/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppStore _appStore = Modular.get<AppStore>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      final bool hasSavedCredentials = await _appStore.check();

      final bool isFirstRun = await _appStore.checkFirstRun();

      if (!mounted) return;

      if (hasSavedCredentials) {
        Modular.to.pushNamedAndRemoveUntil('/home/', (_) => false);
        return;
      }

      if (isFirstRun == true) {
        Modular.to.pushNamedAndRemoveUntil('/auth/intro', (_) => false);
      } else {
        Modular.to.pushNamedAndRemoveUntil('/auth/', (_) => false);
      }
    } catch (e) {
      Modular.to.pushNamedAndRemoveUntil('/auth/', (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFF22F52);
    final width = MediaQuery.of(context).size.width;
    final logoSize = width * 0.70;

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Image.asset(
          'assets/app/splash-screen.png',
          fit: BoxFit.fill,
          width: logoSize,
        ),
      ),
    );
  }
}
