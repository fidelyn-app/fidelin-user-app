import 'package:fidelin_user_app/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:fidelin_user_app/app/modules/home/utils/formatters/uppercase_text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class InputCode extends StatefulWidget {
  final String? type;

  InputCode({super.key, this.type});

  @override
  State<InputCode> createState() => _InputCodeState();
}

class _InputCodeState extends State<InputCode> {
  final HomeController _homeController = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    var title = '';
    var subtitle = '';

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
        child: Padding(
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
                      fieldWidth: 50, // largura de cada campo (padrão é 45)
                      borderRadius: BorderRadius.circular(12),
                      focusedBorderColor: const Color(0xFFF22F52),
                      inputFormatters: [UpperCaseTextFormatter()],
                      cursorColor: const Color(0xFFF22F52),
                      textStyle: TextStyle(
                        color: const Color(0xFFF22F52),
                        fontWeight: FontWeight.bold, // 🅱️ Negrito
                        fontSize: 24,
                      ),
                      onSubmit: (String verificationCode) {
                        // showDialog(
                        //   context: context,
                        //   builder:
                        //       (context) => AlertDialog(
                        //         title: Text("Código inserido"),
                        //         content: Text("O código é: $verificationCode"),
                        //       ),
                        // );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: _submitCode,
                  child: Text(
                    "Confirmar",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitCode() {
    //_homeController.addPoint(pointId: '');
    Modular.to.pushNamedAndRemoveUntil('/home/', (p0) => false);
  }
}
