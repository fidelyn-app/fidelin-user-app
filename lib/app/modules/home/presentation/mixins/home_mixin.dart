import 'package:fidelin_user_app/app/modules/home/presentation/controllers/input_code_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin HomeMixin<T extends StatefulWidget> on State<T> {
  InputCodeController inputCodeController = Modular.get<InputCodeController>();
}
