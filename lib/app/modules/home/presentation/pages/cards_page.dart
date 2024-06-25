import 'dart:math';

import 'package:fidelin_user_app/app/core/stores/user_store.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/controllers/cards_controller.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class CardsPage extends StatefulWidget {
  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage>
    with AutomaticKeepAliveClientMixin<CardsPage> {
  bool get wantKeepAlive => true;
  final UserStore _userStore = Modular.get<UserStore>();
  final CardsController _cardsController = Modular.get<CardsController>();

  @override
  void initState() {
    super.initState();

    _cardsController.fetchUserCards();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: SafeArea(
            top: true,
            child: Observer(
              builder: (_) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: constraints.maxHeight * 0.25,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28.0, vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Olá, ${_userStore.user!.firstName}",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 32,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          const Text(
                            "Seus cartões fidelidade em um só lugar!",
                          ),
                        ],
                      ),
                    ),
                  ),
                  _cardsController.isLoading
                      ? const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Expanded(
                          child: _cardsController.cards.isNotEmpty
                              ? ScrollSnapList(
                                  dynamicSizeEquation: (double scale) {
                                    return 1 -
                                        min(scale.abs() / 1000,
                                            0.2); // Distancia entre os itens
                                  },
                                  onItemFocus: (_) => {},
                                  itemSize: constraints.maxWidth /
                                      1.40, // Cada Cartão tem 40% de distancia da margem
                                  itemBuilder: (context, index) => CardWidget(
                                      constraints: constraints, index: index),
                                  itemCount: _cardsController.cards.length,
                                  dynamicItemSize: true,
                                )
                              : const Center(
                                  child: Text("Você não possui cartões")),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
