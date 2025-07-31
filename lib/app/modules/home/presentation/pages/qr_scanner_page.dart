import 'package:fidelin_user_app/app/modules/home/presentation/mixins/home_mixin.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/widgets/dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> with HomeMixin {
  final MobileScannerController controller = MobileScannerController();
  bool _isProcessing = false;

  @override
  void dispose() {
    // É crucial descartar o controller para liberar a câmera quando o widget
    // não estiver mais na tela.
    controller.dispose();
    super.dispose();
  }

  void handleQrScannerCode(String code) {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    // Regex para validar o formato 'CARD:xxxxxx' ou 'CODE:xxxxxx'
    // ^           - início da string
    // (CARD|CODE) - corresponde a "CARD" ou "CODE" (ignora maiúsculas/minúsculas)
    // :           - corresponde ao caractere de dois pontos
    // [a-zA-Z0-9]{6} - corresponde a exatamente 6 caracteres alfanuméricos
    // $           - fim da string
    final RegExp formatValidator = RegExp(
      r'^(CARD|POINT):[a-zA-Z0-9]{6}$',
      caseSensitive: false,
    );

    if (formatValidator.hasMatch(code)) {
      final comand = code.split(':')[0];
      final value = code.split(':')[1];

      switch (comand) {
        case 'CARD':
          inputCodeController.addCard(shortCodeId: value);
          break;
        case 'POINT':
          inputCodeController.addPoint(shortCodeId: value);
          break;
        default:
          break;
      }

      Navigator.pop(context, code);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('QR Code com formato inválido.'),
          backgroundColor: Colors.red,
        ),
      );
      // Aguarda um pouco antes de permitir uma nova leitura para evitar múltiplas mensagens
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _isProcessing = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ler QrCode")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: controller,
                      fit: BoxFit.contain,
                      onDetect: (capture) {
                        if (capture.barcodes.isNotEmpty &&
                            capture.barcodes.first.rawValue != null) {
                          handleQrScannerCode(capture.barcodes.first.rawValue!);
                        }
                      },
                    ),
                    Center(
                      child: DashedBorderContainer(width: 250, height: 250),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Modular.to.pushNamed('/home/input_code?type=point');
                },
                icon: Icon(
                  Icons.stars,
                  color: Theme.of(context).colorScheme.surface,
                ), // ícone vermelho
                label: Text(
                  "Adicionar Ponto",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color:
                        Theme.of(context).colorScheme.surface, // texto vermelho
                  ),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () {
                  Modular.to.pushNamed('/home/input_code?type=card');
                },
                icon: Icon(
                  Icons.style,
                  color: Theme.of(context).colorScheme.primary,
                ), // ícone vermelho
                label: Text(
                  "Adicionar Cartão",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color:
                        Theme.of(context).colorScheme.primary, // texto vermelho
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // fundo branco
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ), // borda vermelha
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
