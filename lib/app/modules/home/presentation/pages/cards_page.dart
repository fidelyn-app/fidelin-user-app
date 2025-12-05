import 'dart:math';

import 'package:fidelyn_user_app/app/core/stores/app_store.dart';
import 'package:fidelyn_user_app/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:fidelyn_user_app/app/modules/home/presentation/widgets/card/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage>
    with AutomaticKeepAliveClientMixin<CardsPage> {
  @override
  bool get wantKeepAlive => true;
  final AppStore _userStore = Modular.get<AppStore>();
  final HomeController _homeController = Modular.get<HomeController>();

  @override
  void initState() {
    super.initState();

    _homeController.fetchUserCards();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Threshold chosen to detect small devices (ex.: iPhone SE 1st gen logical height = 568).
          // You can tweak `seHeightThreshold` if you want to target different devices.
          const double seHeightThreshold = 568.0;
          final double headerFactor =
              constraints.maxHeight <= seHeightThreshold ? 0.20 : 0.24;

          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: SafeArea(
              top: true,
              child: Observer(
                builder:
                    (_) => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: constraints.maxHeight * headerFactor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28.0,
                              vertical: 16.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Olá, ${_userStore.user!.firstName}",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                const Text(
                                  "Seus cartões fidelidade em um só lugar!",
                                ),
                              ],
                            ),
                          ),
                        ),
                        _homeController.isLoading
                            ? const Expanded(
                              child: Center(child: CircularProgressIndicator()),
                            )
                            : Expanded(
                              child:
                                  _homeController.cards.isNotEmpty
                                      ? ScrollSnapList(
                                        dynamicSizeEquation: (double scale) {
                                          return 1 -
                                              min(
                                                scale.abs() / 1000,
                                                0.2,
                                              ); // Distancia entre os itens
                                        },
                                        onItemFocus:
                                            _homeController.onFocusCard,
                                        itemSize:
                                            constraints.maxWidth /
                                            1.3, // Cada Cartão tem 40% de distancia da margem
                                        itemBuilder:
                                            (context, index) => CardWidget(
                                              constraints: constraints,
                                              index: index,
                                            ),
                                        itemCount: _homeController.cards.length,
                                        dynamicItemSize: true,
                                      )
                                      : Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0,
                                            vertical: 16.0,
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 16),
                                              SvgPicture.asset(
                                                'assets/images/no_cards.svg',
                                                width: 150,
                                                height: 150,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(height: 16),
                                              const Text(
                                                "Você não possui cartões",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              const Text(
                                                "Clique no botão com símbolo de QR code e adicione um cartão ou ponto.",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                            ),
                      ],
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
