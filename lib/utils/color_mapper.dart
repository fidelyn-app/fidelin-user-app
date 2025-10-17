import 'dart:ui';

class ColorMapper {
  // static Color hexToColor(String hex) {
  //   final int colorInt = int.parse(hex.substring(1), radix: 16);
  //   final alpha = (hex.length == 7) ? (colorInt & 0xFF000000) >> 24 : 0xFF;
  //   return Color(colorInt & 0x00FFFFFF | alpha);
  // }

  static Color hexToColor(String hexString) {
    if (hexString.isEmpty) {
      throw ArgumentError('Invalid hex string');
    }

    final regex = RegExp(r'^#?([0-9a-fA-F]{6}|[0-9a-fA-F]{3})$');
    if (!regex.hasMatch(hexString)) {
      throw const FormatException('Invalid hex color format');
    }

    final rgbString = hexString.substring(1);
    final value = int.parse("FF$rgbString", radix: 16);

    if (rgbString.length == 6) {
      return Color(value);
    } else {
      // Add missing alpha channel (opacity) for 3-digit hex codes
      final alpha = int.parse('FF', radix: 16);
      return Color(alpha << 24 | value);
    }
  }

  static String colorToHex(Color color) {
    final red = color.red.toRadixString(16).padLeft(2, '0');
    final green = color.green.toRadixString(16).padLeft(2, '0');
    final blue = color.blue.toRadixString(16).padLeft(2, '0');
    // final alpha = (color.alpha == 0xFF)
    //     ? ''
    //     : color.alpha.toRadixString(16).padLeft(2, '0');
    return '#$red$green$blue';
  }
}
