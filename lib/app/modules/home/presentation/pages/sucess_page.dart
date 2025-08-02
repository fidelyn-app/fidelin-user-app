import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Tela exibida quando a operação for concluída com sucesso.
class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const Text(
                'Sucesso!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Seu cartão/ponto foi adicionado com sucesso! 🎉🥳 ',
                style: const TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Ilustração de sucesso
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/dialog_success.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Botão de voltar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
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
                      color: Color(0xFFEF3F5F),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
