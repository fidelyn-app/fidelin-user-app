import 'package:fidelin_user_app/app/core/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CheckEmailPage extends StatelessWidget {
  const CheckEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
          ),
          onPressed: () {
            Modular.to.pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 200,
                        child: Image.asset('assets/images/mail_sent.png'),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        "Verifique seu E-mail",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const Text(
                        "Enviamos um link para redefinir sua senha.",
                        textAlign: TextAlign.center,
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            Modular.to.popUntil((route) => route.isFirst),
                        child: Text(
                          "Ok",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).colorScheme.surface),
                        ),
                      ),
                      SpaceWidget(size: SpaceSize.xxl),
                    ],
                  ),
                )),
      ),
    );
  }
}
