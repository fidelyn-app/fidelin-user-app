import 'package:fidelin_user_app/app/core/widgets/spacer.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/controllers/forgot_password_controller.dart';
import 'package:fidelin_user_app/app/modules/auth/presentation/mixins/home_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CheckEmailPage extends StatefulWidget {
  const CheckEmailPage({super.key});

  @override
  State<CheckEmailPage> createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage> with AuthMixin {
  final ForgotPasswordController _controller =
      Modular.get<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () {
            Modular.to.pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder:
            (
              BuildContext context,
              BoxConstraints constraints,
            ) => ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 200,
                              child: Image.asset('assets/images/mail_sent.png'),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              "Verifique seu E-mail",
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16.0),
                            const Text(
                              "Enviamos um código para redefinir sua senha.",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Código',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(Icons.numbers),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Row(
                      children: <Widget>[
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "&",
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16.0),
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
                                color: Theme.of(context).colorScheme.primary,
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
                          controller: _controller.confirmPasswordTextController,
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
                                color: Theme.of(context).colorScheme.primary,
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
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed:
                          () => forgotPasswordController.updatePassword(),
                      child: Text(
                        "Confirmar",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                    SpaceWidget(size: SpaceSize.xxl),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
