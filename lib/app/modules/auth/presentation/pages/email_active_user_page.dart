import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EmailActiveUserPage extends StatelessWidget {
  const EmailActiveUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Remove a seta de voltar padrão
        actions: [
          IconButton(
            icon: const Icon(Icons.close, size: 28),
            onPressed: () {
              // Ação para fechar a página, por exemplo, voltar para a tela de login
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),

      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Image.asset('assets/images/mail_sent.png'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Verifique seu E-mail",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Enviamos um link de ativação para o seu endereço de e-mail. Por favor, verifique sua caixa de entrada e spam para ativar sua conta.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Modular.to.popUntil((route) => route.isFirst);
            },
            child: Text(
              "Ir para o Login",
              style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
