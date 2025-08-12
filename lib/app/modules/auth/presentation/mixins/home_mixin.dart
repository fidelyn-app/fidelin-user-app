import 'package:fidelin_user_app/app/modules/auth/presentation/controllers/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin AuthMixin<T extends StatefulWidget> on State<T> {
  ForgotPasswordController forgotPasswordController =
      Modular.get<ForgotPasswordController>();
}
