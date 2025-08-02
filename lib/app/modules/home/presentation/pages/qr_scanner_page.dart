import 'package:fidelin_user_app/app/modules/home/presentation/mixins/home_mixin.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/widgets/dashed_container.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mobx/mobx.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> with HomeMixin {
  final MobileScannerController controller = MobileScannerController();
  bool _isProcessing = false;

  late ReactionDisposer _successDisposer;
  late ReactionDisposer _errorDisposer;

  @override
  void initState() {
    super.initState();

    // Dispara um diálogo de sucesso quando inputCodeController.success mudar para true
    // _successDisposer = reaction<bool>((_) => inputCodeController.success, (
    //   success,
    // ) {
    //   if (success) {
    //     showDialog(
    //       context: context,
    //       barrierDismissible: true,
    //       builder:
    //           (_) => const DialogWidget(
    //             title: 'Sucesso',
    //             description: 'Seu cartão/ponto foi adicionado com sucesso!',
    //             icon: Icons.check_circle,
    //             iconColor: Colors.greenAccent,
    //           ),
    //     ).then((_) {
    //       Modular.to.pushNamedAndRemoveUntil('/home/', (p0) => false);
    //     });
    //   }
    // });

    // // Dispara um diálogo de erro quando inputCodeController.error mudar para true
    // _errorDisposer = reaction<bool>((_) => inputCodeController.error, (error) {
    //   if (error) {
    //     showDialog(
    //       context: context,
    //       barrierDismissible: true,
    //       builder:
    //           (_) => const DialogWidget(
    //             title: 'Erro',
    //             description: 'Não foi possível realizar a operação.',
    //             icon: Icons.error,
    //             iconColor: Colors.redAccent,
    //           ),
    //     ).then((_) {
    //       Modular.to.pushNamedAndRemoveUntil('/home/', (p0) => false);
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleQrScannerCode(String code) async {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    final RegExp formatValidator = RegExp(
      r'^(CARD|POINT):[a-zA-Z0-9]{6}$',
      caseSensitive: false,
    );

    if (formatValidator.hasMatch(code)) {
      final command = code.split(':')[0];
      final value = code.split(':')[1];

      switch (command.toUpperCase()) {
        case 'CARD':
          await inputCodeController.addCard(shortCodeId: value);
          break;
        case 'POINT':
          inputCodeController.addPoint(shortCodeId: value);
          break;
        default:
          break;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('QR Code com formato inválido.'),
          backgroundColor: Colors.red,
        ),
      );
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _isProcessing = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ler QrCode")),
      body: Observer(
        builder: (_) {
          if (inputCodeController.error) {
            Modular.to.pushNamed('/home/error');
          }

          if (inputCodeController.success) {
            Modular.to.pushNamed('/home/success');
          }
          if (inputCodeController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
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
                              handleQrScannerCode(
                                capture.barcodes.first.rawValue!,
                              );
                            }
                          },
                        ),
                        const Center(
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
                    ),
                    label: Text(
                      "Adicionar Ponto",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      Modular.to.pushNamed('/home/input_code?type=card');
                    },
                    icon: Icon(
                      Icons.style,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: Text(
                      "Adicionar Cartão",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
