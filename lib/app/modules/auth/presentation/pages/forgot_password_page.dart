import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final ForgotPasswordController _controller =
      Modular.get<ForgotPasswordController>();

  void _handleForgotPasswordRequest(String email) {
    // _controller.requestForgotPassword(email: email).then((bool? value) {
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) => const CheckEmailPage(),
    //     ),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Image.asset('assets/images/forgot_password.png'),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "Esqueceu a \nSenha?",
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Text(
                        "Não se preocupe! Acontece. Por favor, insira o seu endereço de e-mail associado à sua conta abaixo para que possamos ajudá-lo(a) a redefinir a sua senha."),
                    const SizedBox(
                      height: 32.0,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-mail',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(
                            Icons.mail,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Observer(
                      builder: (_) => ElevatedButton(
                        onPressed: () => _handleForgotPasswordRequest(
                            "jonatha_rihan@hotmail.com"),
                        child: _controller.loading
                            ? SizedBox(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                                height: 25.0,
                                width: 25.0,
                              )
                            : Text(
                                "Enviar",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 48.0,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
