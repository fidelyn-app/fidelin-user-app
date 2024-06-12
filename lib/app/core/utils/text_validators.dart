class Validators {
  static String? email(String? value) {
    if (value!.isEmpty) {
      return 'Insira um email';
    }
    bool emailValid = RegExp(
            r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)")
        .hasMatch(value);
    if (!emailValid) {
      return "Insira um email válido";
    }
    return null;
  }

  static String? password(String? value) {
    if (value!.isEmpty) {
      return 'Insira uma senha';
    }
    bool passwordValid = RegExp(r"(?=.{8,})").hasMatch(value);
    if (!passwordValid) {
      return "Insira uma senha válida (deve conter 8 caracteres)";
    }
    return null;
  }

  static String? name(String? value) {
    if (value!.isEmpty) {
      return 'Insira uma nome';
    }
    bool passwordValid = RegExp(
            r"([a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)")
        .hasMatch(value);
    if (!passwordValid) {
      return "Insira um nome válido (Nome e Sobrenome)";
    }
    return null;
  }
}
