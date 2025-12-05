import 'package:fidelyn_user_app/utils/buttons_theme.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmButtonText = 'Confirmar',
    String cancelButtonText = 'Cancelar',
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    double initialChildSize = 0.5,
  }) {
    final styles = Theme.of(context).extension<AppButtonStyles>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: 0.5,
          maxChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(48)),
              ),
              child: Column(
                children: [
                  // 🔹 Área rolável
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 100,
                              height: 5,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            '⚠',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 🔹 Botões fixos no rodapé
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: onConfirm,
                            child: Text(confirmButtonText),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            style: styles?.secondary,
                            onPressed:
                                onCancel ?? () => Navigator.of(context).pop(),
                            child: Text(cancelButtonText),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  final String title;
  final String message;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final double initialChildSize;

  const BottomSheetWidget._({
    required this.title,
    required this.message,
    required this.confirmButtonText,
    required this.cancelButtonText,
    required this.onConfirm,
    this.onCancel,
    required this.initialChildSize,
  });
}
