import 'package:fidelin_user_app/app/core/widgets/spacer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/signup_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpController _controller = Modular.get<SignUpController>();
  late TapGestureRecognizer _termsRecognizer;
  late TapGestureRecognizer _privacyRecognizer;

  @override
  void initState() {
    super.initState();
    _termsRecognizer =
        TapGestureRecognizer()
          ..onTap = () {
            Modular.to.pushNamed('/auth/terms-and-conditions');
          };

    _privacyRecognizer =
        TapGestureRecognizer()
          ..onTap = () {
            Modular.to.pushNamed('/auth/privacy-policy');
          };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                        // SizedBox(
                        //   height: 150,
                        //   child: Image.asset('assets/images/white-logo.png'),
                        // ),
                        // SpaceWidget(size: SpaceSize.xxl),
                        Text(
                          "Cadastre-se",
                          style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        SpaceWidget(size: SpaceSize.xl),
                        TextFormField(
                          // validator: Validators.name,
                          controller: _controller.nameTextController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome completo',
                            prefixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Icon(Icons.person),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          // validator: Validators.email,
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
                          builder: (_) {
                            return TextFormField(
                              validator: _controller.passwordEquals,
                              controller: _controller.passwordTextController,
                              obscureText: !_controller.passwordVisible,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Senha',
                                suffixIcon: IconButton(
                                  onPressed:
                                      () => _controller.togglePasswordVisible(),
                                  icon: Icon(
                                    _controller.passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                prefixIcon: const Align(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: Icon(Icons.lock),
                                ),
                              ),
                            );
                          },
                        ),
                        SpaceWidget(size: SpaceSize.l),
                        Observer(
                          builder: (_) {
                            return TextFormField(
                              validator: _controller.passwordEquals,
                              controller:
                                  _controller.confirmPasswordTextController,
                              obscureText: !_controller.passwordVisible,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Confirmação de senha',
                                suffixIcon: IconButton(
                                  onPressed:
                                      () =>
                                          _controller
                                              .toggleConfirmPasswordVisible(),
                                  icon: Icon(
                                    _controller.passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                prefixIcon: const Align(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: Icon(Icons.lock),
                                ),
                              ),
                            );
                          },
                        ),
                        SpaceWidget(size: SpaceSize.xl),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black54),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Ao criar a conta você concorda com os ',
                              ),
                              TextSpan(
                                text: 'Termos de uso',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                recognizer: _termsRecognizer,
                              ),
                              TextSpan(text: ' e '),
                              TextSpan(
                                text: 'Política de Privacidade',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                recognizer: _privacyRecognizer,
                              ),
                            ],
                          ),
                        ),
                        SpaceWidget(size: SpaceSize.xl),
                        Observer(
                          builder:
                              (_) => ElevatedButton(
                                onPressed:
                                    _controller.isLoading
                                        ? null
                                        : () => _controller.signUp(),
                                child:
                                    _controller.isLoading
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
                                          "Criar conta",
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
                        SpaceWidget(size: SpaceSize.m),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Já possui uma conta? faça ',
                                style: TextStyle(color: Colors.black54),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Login!',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap =
                                              () => Modular.to
                                                  .pushReplacementNamed(
                                                    '/auth/',
                                                  ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
}
