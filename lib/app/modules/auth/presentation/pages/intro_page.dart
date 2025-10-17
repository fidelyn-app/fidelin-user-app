import 'package:fidelin_user_app/app/modules/auth/presentation/mixins/auth_mixin.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroPage extends StatelessWidget with AuthMixin {
  const IntroPage({super.key});

  List<PageViewModel> _getPages(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    return [
      PageViewModel(
        title: "Bem-vindo ao Fidelyn! ❤️",
        body:
            "Seus cartões de fidelidade todos em um só lugar. Acumule pontos e resgate ofertas com facilidade.",
        image: Center(
          child: SvgPicture.asset(
            'assets/images/intro/transform.svg',
            width: 275,
            height: 275,
            fit: BoxFit.fill,
            semanticsLabel: 'Logo da empresa',
          ),
        ),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: colorTheme.surface,
          ),
          bodyTextStyle: TextStyle(
            fontSize: 18,
            color: colorTheme.surface,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      PageViewModel(
        title: "Digitalize-se 💡",
        body:
            "Se dinheiro e documentos estão em seu smartphone, por que não seus cartões de fidelidade?",
        image: Center(
          child: SvgPicture.asset(
            'assets/images/intro/wallet.svg',
            width: 275,
            height: 275,
            fit: BoxFit.fill,
            semanticsLabel: 'Logo da empresa',
          ),
        ),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: colorTheme.surface,
          ),
          bodyTextStyle: TextStyle(fontSize: 18, color: colorTheme.surface),
        ),
      ),
      PageViewModel(
        title: "Rápido, Fácil e a Distância!",
        body:
            "Com o Fidelyn, você pode resgatar pontos e prêmios com facilidade, sem a necessidade de sair do aplicativo. Lendo o QR Code ou Digitando o Código.",
        image: Center(
          child: SvgPicture.asset(
            'assets/images/intro/camera_qr_vertical.svg',
            width: 275,
            height: 275,
            fit: BoxFit.fill,
            semanticsLabel: 'Logo da empresa',
          ),
        ),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: colorTheme.surface,
          ),
          bodyTextStyle: TextStyle(fontSize: 18, color: colorTheme.surface),
        ),
      ),
      PageViewModel(
        title: "Segurança é tudo!🔒",
        body:
            "Todos os dados são criptografados e não solicitamos dados sensíveis. Para mais informações acesse a Política de Privacidade.",
        image: Center(
          child: SvgPicture.asset(
            'assets/images/intro/security.svg',
            width: 200,
            height: 200,
            fit: BoxFit.fill,
            semanticsLabel: 'Logo da empresa',
          ),
        ),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colorTheme.surface,
          ),
          bodyTextStyle: TextStyle(fontSize: 16, color: colorTheme.surface),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorTheme.primary,
      body: SafeArea(
        child: IntroductionScreen(
          pages: _getPages(context),
          done: const Text(
            "Começar",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onDone: () => Modular.to.navigate('/auth/'),
          next: Icon(Icons.arrow_forward, color: colorTheme.surface, size: 24),
          showSkipButton: true,
          skip: Text(
            "Pular",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: colorTheme.surface,
              fontSize: 18,
            ),
          ),
          globalBackgroundColor: colorTheme.primary,
          dotsDecorator: DotsDecorator(
            size: Size(10.0, 10.0),
            color: colorTheme.tertiary,
            activeColor: colorTheme.surface,
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }
}
