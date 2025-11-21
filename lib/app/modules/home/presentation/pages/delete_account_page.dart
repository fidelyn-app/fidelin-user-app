// ignore_for_file: must_be_immutable

import 'package:fidelin_user_app/app/core/widgets/spacer.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/controllers/delete_account_controller.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/mixins/home_mixin.dart';
import 'package:fidelin_user_app/utils/buttons_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> with HomeMixin {
  final DeleteAccountController _deleteAccountController =
      Modular.get<DeleteAccountController>();

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Deletar Conta",
          style: TextStyle(
            color: colorTheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorTheme.surface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorTheme.primary, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Observer(
        builder: (BuildContext context) {
          if (_deleteAccountController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/delete_alert.svg',
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                        semanticsLabel: 'Logo da empresa',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Atenção!',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      SpaceWidget(size: SpaceSize.xxl),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 28.0,
                        ),

                        child: Text(
                          'Ao excluir sua conta, você perderá imediatamente:',
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      _bullet("Todos os seus cartões fidelidade;"),
                      _bullet("Seus pontos acumulados;"),
                      _bullet("Seu histórico de recompensas."),
                      SpaceWidget(size: SpaceSize.xxl),
                    ],
                  ),
                ),
                _textAlert(
                  context,
                  'Essa ação é irreversível e seus dados não poderão ser recuperados.',
                ),
                _cancelButton(),
                _confirmButton(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _textAlert(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 28),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _confirmButton(BuildContext context) {
    final styles = Theme.of(context).extension<AppButtonStyles>();

    return Padding(
      padding: const EdgeInsets.only(left: 28.0, right: 28.0, bottom: 14.0),
      child: ElevatedButton(
        style: styles?.secondary,
        onPressed: () async {
          final result = await showDeleteConfirmDialog(
            context,
            email: appStore.user!.email,
          );
          if (result == true) {
            _deleteAccountController.deleteAccount();
          } else {
            // usuário cancelou
          }
        },
        child: Text(' ⚠ Continuar para exclusão'),
      ),
    );
  }

  Widget _cancelButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 28),
      child: ElevatedButton(
        onPressed: () {
          Modular.to.pop();
        },
        child: Text('Manter minha conta'),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16.0)),
          Text(text, style: TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }
}

Future<bool?> showDeleteConfirmDialog(
  BuildContext context, {
  required String email,
}) {
  final TextEditingController controller = TextEditingController();
  // Não permitir fechar clicando fora
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          final entered = controller.text.trim();
          final enabled = entered.toUpperCase() == 'DELETAR';

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            title: Center(
              child: Text(
                'Atenção!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 6),
                  Text(
                    'Para confirmar a exclusão permanente da conta associada ao e-mail $email, digite a palavra ',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'DELETAR',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: controller,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      //hintText: 'Digite DELETAR para confirmar',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (_) {
                      setState(() {}); // atualiza botão habilitado
                    },
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            enabled
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: enabled ? 2 : 0,
                      ),
                      onPressed:
                          enabled
                              ? () {
                                Navigator.of(context).pop(true); // confirmação
                              }
                              : null,
                      child: const Text('Apagar tudo permanentemente'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false); // cancelar
                      },
                      child: const Text('Manter minha conta'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
