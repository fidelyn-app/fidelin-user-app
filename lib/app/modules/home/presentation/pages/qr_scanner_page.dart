import 'package:fidelin_user_app/app/modules/home/presentation/widgets/dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatelessWidget {
  const QRScannerPage({super.key});

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
                      controller: MobileScannerController(),
                      fit: BoxFit.contain,
                      onDetect: (BarcodeCapture capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        if (barcodes.isNotEmpty) {
                          final String? code = barcodes.first.rawValue;
                          if (code != null) {
                            Navigator.pop(context, code);
                          }
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
