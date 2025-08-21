import 'package:fidelin_user_app/app/modules/home/domain/entities/user_card_entity.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/widgets/card/point_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:math' as math;

class CardFront extends StatelessWidget {
  final UserCard userCard;
  final double width;

  const CardFront({super.key, required this.userCard, required this.width});

  @override
  Widget build(BuildContext context) {
    final backgroundUrl = userCard.card.style.backgroundUrl;
    final isCardActive = userCard.card.active;

    Widget backgroundWidget;

    if (backgroundUrl != null) {
      if (backgroundUrl.toLowerCase().endsWith('.json')) {
        backgroundWidget = Positioned.fill(
          child: Lottie.network(backgroundUrl, fit: BoxFit.cover, repeat: true),
        );
      } else {
        backgroundWidget = Positioned.fill(
          child: Image.network(backgroundUrl, fit: BoxFit.cover),
        );
      }
    } else {
      backgroundWidget = Container(color: userCard.card.style.colorPrimary);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: width,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          children: [
            backgroundWidget,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _header(userCard, context),
                _avatar(userCard),
                _titleAndSubtitle(userCard),
                _gridPoints(userCard, context),
                //_bottom(userCard),
              ],
            ),
            !isCardActive ? foreground() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget foreground() {
    return Container(
      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning, color: Colors.yellow),
            SizedBox(height: 10),
            Text(
              'Cartão Pausado',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _titleAndSubtitle(UserCard userCard) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      children: [
        const SizedBox(height: 8.0),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            userCard.card.style.title ?? userCard.card.store.businessName,
            style: const TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        userCard.card.style.subtitle != null
            ? Text(
              userCard.card.style.subtitle ?? userCard.card.store.businessName,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            )
            : const SizedBox(),
      ],
    ),
  );
}

Widget _header(UserCard userCard, BuildContext context) {
  return SizedBox(
    width: double.infinity,
    height: 56, // ajuste se quiser
    child: Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Text(
            "${userCard.points.length}/${userCard.card.maxPoints}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: PopupMenuButton(
            icon: Icon(MdiIcons.dotsVertical, color: Colors.white, size: 32),
            itemBuilder: (ctx) => [_buildPopupMenuItem('Excluir')],
          ),
        ),
      ],
    ),
  );
}

Widget _avatar(UserCard userCard) {
  return Visibility(
    visible: true,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 52.0,
            child:
                userCard.card.store.avatarUrl != null
                    ? CircleAvatar(
                      backgroundImage: NetworkImage(
                        '${userCard.card.store.avatarUrl}',
                      ),
                      radius: 50.0,
                    )
                    : const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      child: Icon(
                        Icons.person,
                        size: 64,
                        color: Colors.black26,
                      ),
                    ),
          ),
        ],
      ),
    ),
  );
}

Widget _gridPoints(UserCard userCard, context) {
  return Expanded(
    child: LayoutBuilder(
      builder:
          (BuildContext context, BoxConstraints constraints) =>
              GridView.builder(
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                itemCount: userCard.card.maxPoints,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: calculateMaxCrossAxisExtent(
                    constraints.maxWidth,
                    constraints.minHeight,
                    userCard.card.maxPoints,
                    itemSpacing: 12,
                  ),
                ),
                itemBuilder:
                    (BuildContext context, int index) => PointWidget(
                      selected: userCard.points.length > index,
                      color: userCard.card.style.colorPrimary,
                      isLastPoint: userCard.card.maxPoints - 1 == index,
                      index: index + 1,
                    ),
              ),
    ),
  );
}

PopupMenuItem _buildPopupMenuItem(String title) {
  return PopupMenuItem(child: Text(title));
}

double calculateMaxCrossAxisExtent(
  double screenWidth,
  double screenHeight,
  int itemCount, {
  double itemSpacing = 1.0,
}) {
  if (itemCount <= 16) {
    return screenWidth / 4;
  }

  final totalArea = (screenWidth - 40) * (screenHeight - 20);

  final areaPerSquare = totalArea / itemCount;

  final idealSideLength = math.sqrt(areaPerSquare / 1).floor();

  return idealSideLength.toDouble();
}
