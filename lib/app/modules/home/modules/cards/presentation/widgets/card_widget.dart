import 'dart:math';

import 'package:fidelin_user_app/app/modules/home/modules/cards/domain/entities/user_card_entity.dart';
import 'package:fidelin_user_app/app/modules/home/modules/cards/presentation/controllers/cards_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CardWidgetPoint extends StatelessWidget {
  final bool selected;
  final bool isLastPoint;
  final Color color;

  const CardWidgetPoint({
    super.key,
    this.selected = false,
    this.color = Colors.black,
    this.isLastPoint = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: color,
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      child: selected
          ? Container(
              margin: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5.0),
              ),
            )
          : isLastPoint
              ? null
              : null,
    );
  }
}

// Future<void> _launchUrl(Uri url) async {
//   if (!await launchUrl(url)) {
//     throw Exception('Could not launch $url');
//   }
// }

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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            userCard.card.backgroundUrl!,
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
      ),
      width: widget.constraints.maxWidth / 1.40,
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
        onPressed: () => _dialogQRCode(context, userCard.id),
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
          child: CircleAvatar(
            backgroundImage: NetworkImage('${userCard.card.store.avatarUrl}'),
            radius: 50.0,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            userCard.card.store.businessName,
            style: const TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    ),
  );
}

Widget _gridPoints(UserCard userCard, context) {
  const show = true;

  return show
      ? Expanded(
          child: GridView.builder(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            itemCount: userCard.card.maxPoints,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: calculateCrossAxisCount(userCard.card.maxPoints),
              crossAxisSpacing: 8,
              mainAxisSpacing: 6,
            ),
            itemBuilder: (BuildContext context, int index) => CardWidgetPoint(
              selected: userCard.points.length > index,
              color: userCard.card.color,
              isLastPoint: userCard.card.maxPoints - 1 == index,
            ),
          ),
        )
      : Expanded(
          child: Center(
          child: Container(
            color: Colors.white,
            child: QrImageView(
              data: userCard.id,
              version: QrVersions.auto,
              size: 250.0,
            ),
          ),
        ));
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

double calculateMaxCrossAxisExtent(BuildContext context) {
  // Use MediaQuery to get screen width
  final screenWidth = MediaQuery.of(context).size.width;

  // Calculate minimum width based on desired layout (e.g., 200 for 2 columns)
  final minItemWidth = 200.0; // Adjust as needed

  // Calculate maximum number of columns that fit comfortably
  final maxColumns = (screenWidth / minItemWidth).floor();

  // Calculate ideal cross axis extent based on max columns and spacing
  final idealExtent = (screenWidth - (maxColumns - 1) * 10) / maxColumns;

  // Handle potential edge cases (very small screens)
  return idealExtent > minItemWidth ? idealExtent : minItemWidth;
}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

int calculateCrossAxisCount(int numberOfItems) {
  double squareRoot = sqrt(numberOfItems);
  int roundedSquareRoot = squareRoot.ceil();

  if (roundedSquareRoot > 4) {
    return squareRoot.ceil();
  } else {
    return 4;
  }
}

Future<void> _dialogQRCode(BuildContext context, String data) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: 250,
          height: 250,
          color: Colors.white,
          child: QrImageView(
            data: data,
            version: QrVersions.auto,
            size: 250.0,
          ),
        ),
      );
    },
  );
}
