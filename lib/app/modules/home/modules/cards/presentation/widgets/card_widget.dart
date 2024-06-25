import 'dart:math' as math;

import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/entities/user_card_entity.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/presentation/controllers/cards_controller.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/presentation/widgets/point_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CardWidget extends StatefulWidget {
  final BoxConstraints constraints;
  final int index;

  const CardWidget({super.key, required this.index, required this.constraints});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final CardsController _cardsController = Modular.get<CardsController>();

  late UserCard userCard;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userCard = _cardsController.cards[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidget = widget.constraints.maxWidth / 1.40;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: userCard.card.style.backgroundUrl != null
          ? BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  userCard.card.style.backgroundUrl!,
                ),
              ),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            )
          : BoxDecoration(
              color: userCard.card.style.backgroundColor,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
      width:
          cardWidget, // Tem que ser igual ao tamanho do afastamento das bordas
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _header(userCard, context),
          _avatar(userCard),
          _gridPoints(userCard, context),
          _bottom(userCard)
        ],
      ),
    );
  }
}

Widget _header(UserCard userCard, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      PopupMenuButton(
        icon: Icon(
          MdiIcons.dotsVertical,
          color: Colors.white,
          size: 32,
        ),
        itemBuilder: (ctx) => [
          _buildPopupMenuItem('Excluir'),
        ],
      ),
      Text(
        "${userCard.points.length}/${userCard.card.maxPoints}",
        style: const TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
      IconButton(
        icon: Icon(
          MdiIcons.qrcode,
          color: Colors.white,
          size: 32,
        ),
        onPressed: () => _dialogQRCode(context, userCard),
      ),
    ],
  );
}

Widget _avatar(UserCard userCard) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 52.0,
          child: userCard.card.store.avatarUrl != null
              ? CircleAvatar(
                  backgroundImage:
                      NetworkImage('${userCard.card.store.avatarUrl}'),
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
        const SizedBox(
          height: 8.0,
        ),
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
                userCard.card.style.subtitle ??
                    userCard.card.store.businessName,
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

Widget _gridPoints(UserCard userCard, context) {
  //Quantidade de items, tamanho do container

  return Expanded(
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) =>
          GridView.builder(
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        itemCount: userCard.card.maxPoints,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: calculateMaxCrossAxisExtent(
            constraints.maxWidth,
            constraints.minHeight,
            userCard.card.maxPoints,
            itemSpacing: 12,
          ),
        ),
        itemBuilder: (BuildContext context, int index) => PointWidget(
          selected: userCard.points.length > index,
          color: userCard.card.style.pointColor,
          isLastPoint: userCard.card.maxPoints - 1 == index,
          index: index + 1,
        ),
      ),
    ),
  );
}

Widget _bottom(UserCard userCard) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Visibility(
        visible: true,
        child: IconButton(
          icon: const Icon(
            FontAwesomeIcons.whatsapp,
            color: Colors.white,
          ),
          onPressed: () {
            final Uri url = Uri.parse(
                "https://wa.me/${userCard.card.store.contacts.phone}?text=Olá!");
            _launchUrl(url);
          },
        ),
      ),
      Visibility(
        visible: true,
        child: IconButton(
          icon: const Icon(
            FontAwesomeIcons.instagram,
            color: Colors.white,
          ),
          onPressed: () async {
            final Uri nativeUrl = Uri.parse(
                "instagram://user?username=${userCard.card.store.contacts.instagram}");
            final Uri webUrl = Uri.parse(
                "https://www.instagram.com/${userCard.card.store.contacts.instagram}/");
            if (await canLaunchUrl(nativeUrl)) {
              await _launchUrl(nativeUrl);
            } else if (await canLaunchUrl(webUrl)) {
              await _launchUrl(webUrl);
            } else {
              print("can't open Instagram");
            }
          },
        ),
      ),
      Visibility(
        visible: true,
        child: IconButton(
          icon: const Icon(
            Icons.phone,
            color: Colors.white,
          ),
          onPressed: () {
            final Uri launchUri = Uri(
              scheme: 'tel',
              path: '+5581996509220',
            );
            _launchUrl(launchUri);
          },
        ),
      ),
      Visibility(
        visible: true,
        child: IconButton(
          icon: const Icon(
            FontAwesomeIcons.globe,
            color: Colors.white,
          ),
          onPressed: () {
            final Uri url = Uri.parse(userCard.card.store.contacts.site!);
            _launchUrl(url);
          },
        ),
      ),
    ],
  );
}

PopupMenuItem _buildPopupMenuItem(String title) {
  return PopupMenuItem(
    child: Text(title),
  );
}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

double calculateMaxCrossAxisExtent(
    double screenWidth, double screenHeight, int itemCount,
    {double itemSpacing = 1.0}) {
  // Calculate the available area per square
  final totalArea = (screenWidth - 40) * (screenHeight - 20);

  final areaPerSquare = totalArea / itemCount;

  // Calculate the ideal side length based on the available area and aspect ratio
  final idealSideLength = math.sqrt(areaPerSquare / 1).floor();

  // Round down to the nearest integer to ensure all squares fit within the total area

  return idealSideLength.toDouble();
}

Future<void> _dialogQRCode(BuildContext context, UserCard userCard) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: 250,
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QrImageView(
                data: userCard.id,
                version: QrVersions.auto,
                size: 250.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                userCard.card.description,
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}
