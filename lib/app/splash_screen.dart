import 'package:fidelin_user_app/app/core/stores/app_store.dart';
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
      // check() retorna true se encontrou user/token e já os setou no store
      final bool hasSavedCredentials = await _appStore.check();

      // verifica se é a primeira execução (popula isFirstRun no store)
      final bool isFirstRun = await _appStore.checkFirstRun();

      if (!mounted) return;

      if (hasSavedCredentials) {
        // já carregou user e token -> vai direto para home
        Modular.to.pushNamedAndRemoveUntil('/home/', (_) => false);
        return;
      }

      // sem credenciais salvas:
      if (isFirstRun == true) {
        // primeira execução -> mostra intro (slides)
        Modular.to.pushNamedAndRemoveUntil('/auth/intro', (_) => false);
      } else {
        // não é primeira execução e não há credenciais:
        // ir para tela de autenticação / login. Ajuste a rota caso necessário.
        Modular.to.pushNamedAndRemoveUntil('/auth/', (_) => false);
      }
    } catch (e) {
      // fallback: se der erro, vai para auth (ou home, se preferir)
      //if (!mounted) return;
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
