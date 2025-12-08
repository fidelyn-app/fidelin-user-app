import 'package:flutter/services.dart';

class PhoneMaskTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    // Remove todos os caracteres não numéricos
    final digitsOnly = text.replaceAll(RegExp(r'[^\d]'), '');

    // Limita a 11 dígitos (DDD + 9 dígitos)
    final limitedDigits =
        digitsOnly.length > 11 ? digitsOnly.substring(0, 11) : digitsOnly;

    // Aplica a máscara (xx) xxxxx-xxxx
    String formatted = '';

    if (limitedDigits.isNotEmpty) {
      // DDD (2 dígitos)
      if (limitedDigits.length <= 2) {
        formatted = '($limitedDigits';
      } else if (limitedDigits.length <= 7) {
        // (xx) xxxxx
        formatted =
            '(${limitedDigits.substring(0, 2)}) ${limitedDigits.substring(2)}';
      } else {
        // (xx) xxxxx-xxxx
        formatted =
            '(${limitedDigits.substring(0, 2)}) ${limitedDigits.substring(2, 7)}-${limitedDigits.substring(7)}';
      }
    }

    // Calcula a nova posição do cursor
    int cursorPosition = formatted.length;

    // Se o usuário está deletando, ajusta a posição do cursor
    if (oldValue.text.length > newValue.text.length) {
      // Se deletou um caractere não numérico, mantém a posição
      if (oldValue.text.length == formatted.length + 1) {
        cursorPosition = newValue.selection.baseOffset;
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }

  /// Remove a máscara e retorna apenas os dígitos
  static String unmask(String maskedPhone) {
    return maskedPhone.replaceAll(RegExp(r'[^\d]'), '');
  }

  /// Aplica a máscara em uma string de telefone
  static String mask(String phone) {
    final digitsOnly = phone.replaceAll(RegExp(r'[^\d]'), '');
    final limitedDigits =
        digitsOnly.length > 11 ? digitsOnly.substring(0, 11) : digitsOnly;

    if (limitedDigits.isEmpty) return '';
    if (limitedDigits.length <= 2) {
      return '($limitedDigits';
    } else if (limitedDigits.length <= 7) {
      return '(${limitedDigits.substring(0, 2)}) ${limitedDigits.substring(2)}';
    } else {
      return '(${limitedDigits.substring(0, 2)}) ${limitedDigits.substring(2, 7)}-${limitedDigits.substring(7)}';
    }
  }
}
