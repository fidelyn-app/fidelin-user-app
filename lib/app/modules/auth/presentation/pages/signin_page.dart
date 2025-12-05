import 'dart:io';

import 'package:fidelin_user_app/app/core/utils/text_validators.dart';
import 'package:fidelin_user_app/app/core/widgets/spacer.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/controllers/signin_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final SignInController _controller = Modular.get<SignInController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder:
            (
              BuildContext context,
              BoxConstraints constraints,
            ) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: _controller.formField,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 150,
                          child: Image.asset('assets/images/white-logo.png'),
                        ),
                        SpaceWidget(size: SpaceSize.xxl),
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        TextFormField(
                          validator: Validators.email,
                          controller: _controller.emailTextController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'E-mail',
                            prefixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Icon(Icons.mail),
                            ),
                          ),
                        ),
                        SpaceWidget(size: SpaceSize.l),
                        Observer(
                          builder:
                              (_) => TextFormField(
                                validator: Validators.password,
                                controller: _controller.passwordTextController,
                                obscureText: !_controller.passwordVisible,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed:
                                        () =>
                                            _controller.togglePasswordVisible(),
                                    icon: Icon(
                                      _controller.passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(),
                                  labelText: 'Senha',
                                  prefixIcon: const Align(
                                    widthFactor: 1.0,
                                    heightFactor: 1.0,
                                    child: Icon(Icons.lock),
                                  ),
                                ),
                              ),
                        ),
                        SpaceWidget(size: SpaceSize.l),
                        RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black54),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Esqueceu a senha?',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap =
                                          () => Modular.to.pushNamed(
                                            '/auth/forgot-password',
                                          ),
                              ),
                            ],
                          ),
                        ),
                        SpaceWidget(size: SpaceSize.l),
                        Observer(
                          builder:
                              (_) => ElevatedButton(
                                onPressed:
                                    _controller.loading
                                        ? null
                                        : () => _controller.signIn(),
                                child:
                                    _controller.loading
                                        ? SizedBox(
                                          height: 25.0,
                                          width: 25.0,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.surface,
                                            ),
                                          ),
                                        )
                                        : Text(
                                          "Entrar",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.surface,
                                          ),
                                        ),
                              ),
                        ),
                        SpaceWidget(size: SpaceSize.l),
                        const Row(
                          children: <Widget>[
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "ou",
                                style: TextStyle(color: Colors.black45),
                              ),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        SpaceWidget(size: SpaceSize.l),
                        SizedBox(
                          height: 50, // 1. Define a altura aqui
                          child: SignInButton(
                            Buttons.google,
                            // 2. Define o Border Radius aqui
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            text: "Entrar com o Google",
                            textStyle: TextStyle(
                              fontSize: 16.0,
                              //color: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed:
                                () => _controller.signInWithGoogleFirebase(),
                          ),
                        ),
                        SpaceWidget(size: SpaceSize.l),
                        Visibility(
                          visible: Platform.isIOS,
                          child: SizedBox(
                            height: 50,
                            child: SignInButton(
                              Buttons.apple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              text: "Entrar com o Apple",
                              textStyle: TextStyle(
                                fontSize: 16.0,
                                //color: Theme.of(context).colorScheme.primary,
                              ),
                              onPressed:
                                  () => _controller.signInWithAppleFirebase(),
                            ),
                          ),
                        ),
                        SpaceWidget(size: SpaceSize.l),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Não tem uma conta? ',
                                style: TextStyle(color: Colors.black54),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Cadastre-se!',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap =
                                              () => Modular.to.pushNamed(
                                                '/auth/signup',
                                              ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SpaceWidget(size: SpaceSize.m),
                        FutureBuilder<String>(
                          future: _getVersion(),
                          builder: (context, snapshot) {
                            final text = snapshot.data ?? '...';
                            return Center(
                              child: Text(
                                text,
                                style: TextStyle(color: Colors.black54),
                              ),
                            );
                          },
                        ),
                        SpaceWidget(size: SpaceSize.xl),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }

  Future<String> _getVersion() async {
    final info = await PackageInfo.fromPlatform();
    return 'v${info.version}';
  }
}
