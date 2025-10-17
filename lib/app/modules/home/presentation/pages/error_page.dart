import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Theme.of(context).colorScheme.primary),
          onPressed:
              () => Modular.to.pushNamedAndRemoveUntil('/home/', (p0) => false),
        ),
        // se você preferir colocar o X à direita:
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.close, color: Colors.white),
        //     onPressed: () => Navigator.pop(context),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ops...!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEF3F5F),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 64),

                    // Ilustração de erro
                    Image.asset(
                      width: 200,
                      height: 200,
                      'assets/images/dialog_error.png',
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 64),
                    Text(
                      "Não foi possível concluir a operação.",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFFEF3F5F),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF3F5F),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed:
                    () => Modular.to.pushNamedAndRemoveUntil(
                      '/home/',
                      (p0) => false,
                    ),
                child: const Text(
                  'Voltar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
