import 'package:fidelyn_user_app/app/modules/home/presentation/widgets/history_card_widget.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico')),
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return HistoryCardWidget(
            storeName: 'Esquina do Pastel',

            rewardDescription:
                'Ao consumir R\$30,00 reais em alimentos no estabelecimento, você acumula 1 ponto no cartão; Ao completar 12 pontos em um periodo de 6 mêses, você ganha um pastel de 3 sabores gratis!',
            avatarUrl:
                'http://bucket-jhxf-production.up.railway.app/store-avatars/1b976eda-3209-4e13-8314-f0595b5d3466.png',
            backgroundImageUrl:
                'http://bucket-jhxf-production.up.railway.app/cards-background/1c14de16-8c91-4e75-ad72-a12fd2af91d7.png',
          );
        },
      ),
    );
  }
}
