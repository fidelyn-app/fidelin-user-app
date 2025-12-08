import 'package:fidelyn_user_app/app/modules/home/presentation/controllers/history_controller.dart';
import 'package:fidelyn_user_app/app/modules/home/presentation/widgets/history_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late HistoryController controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = Modular.get<HistoryController>();
    _scrollController.addListener(_onScroll);
    controller.fetchHistory();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      controller.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico')),
      body: Observer(
        builder: (_) {
          if (controller.isLoading && controller.historyCards.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.historyCards.isEmpty) {
            return const Center(child: Text('Nenhum histórico encontrado'));
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount:
                controller.historyCards.length +
                (controller.isLoadingMore ? 1 : 0),
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              if (index >= controller.historyCards.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final card = controller.historyCards[index];
              return HistoryCardWidget(userCard: card);
            },
          );
        },
      ),
    );
  }
}
