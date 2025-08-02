import 'package:fidelin_user_app/app/modules/home/presentation/mixins/home_mixin.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/widgets/dialog.dart';
import 'package:fidelin_user_app/app/modules/home/utils/formatters/uppercase_text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class InputCode extends StatefulWidget {
  final String? type;

  const InputCode({super.key, this.type});

  @override
  State<InputCode> createState() => _InputCodeState();
}

class _InputCodeState extends State<InputCode> with HomeMixin {
  List<TextEditingController?> _controllers = [];

  @override
  Widget build(BuildContext context) {
    var title = '';
    var subtitle = '';

    var code = '';

    switch (widget.type) {
      case 'card':
        title = 'Código do cartão';
        subtitle = 'O cartão será adicionado a sua carteira';
        break;
      case 'point':
        title = 'Código do ponto';
        subtitle = 'O ponto será adicionado ao seu cartão selecionado';
        break;
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final maxHeight = constraints.maxHeight;

            return Observer(
              builder: (_) {
                if (inputCodeController.error) {
                  Modular.to.pushNamed('/home/error');
                }

                if (inputCodeController.success) {
                  Modular.to.pushNamed('/home/success');
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(subtitle),
                            SizedBox(height: 48),
                            OtpTextField(
                              numberOfFields: 6,
                              borderColor: const Color(0xFFF22F52),
                              showFieldAsBox: true,
                              keyboardType: TextInputType.text,
                              fieldWidth: maxWidth / 8.2,
                              borderRadius: BorderRadius.circular(12),
                              focusedBorderColor: const Color(0xFFF22F52),
                              inputFormatters: [UpperCaseTextFormatter()],
                              cursorColor: const Color(0xFFF22F52),
                              textStyle: TextStyle(
                                color: const Color(0xFFF22F52),
                                fontWeight: FontWeight.bold, // 🅱️ Negrito
                                fontSize: 24,
                              ),
                              onSubmit: (String verificationCode) {},
                              handleControllers: (controllers) {
                                _controllers = controllers;
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Observer(
                          builder:
                              (_) => ElevatedButton(
                                onPressed:
                                    inputCodeController.isLoading
                                        ? null
                                        : () => _submitCode(),
                                child:
                                    inputCodeController.isLoading
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
                                          "Confirmar",
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
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _submitCode() async {
    String code = _controllers.map((c) => c?.text ?? '').join();

    switch (widget.type) {
      case 'card':
        await inputCodeController.addCard(shortCodeId: code);
        break;
      case 'point':
        await inputCodeController.addPoint(shortCodeId: code);
        break;
    }
  }
}
