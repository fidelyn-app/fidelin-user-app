import 'package:fidelin_user_app/app/modules/home/domain/entities/user_card_entity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'countdown_time.dart';

class CardBack extends StatelessWidget {
  final UserCard userCard;
  final double width;

  const CardBack({super.key, required this.userCard, required this.width});

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
      backgroundWidget = Container(
        color: userCard.card.style.colorPrimary.withValues(alpha: 0.95),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: width,
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _header(userCard, context),

                      _qrCode(userCard.id),

                      _rewardDescription2(),
                    ],
                  ),
                ),
                _countDown(),
                _bottom(userCard),
              ],
            ),
            !isCardActive ? foreground() : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _countDown() {
    final expiration = userCard.expiration;
    if (expiration == null) {
      return const SizedBox.shrink(); // nada é criado
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CountdownTimer(
        expiration: expiration,
        onExpired: () {
          print('Expirou!');
        },
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        userCard: userCard,
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

// Widget _rewardDescription() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
//     child: Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
//       decoration: BoxDecoration(
//         color: Colors.white54,
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       child: const Text(
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
//         textAlign: TextAlign.center,
//         style: TextStyle(color: Colors.black),
//       ),
//     ),
//   );
// }

Widget _rewardDescription2() {
  const text =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
    child: AutoSizeText(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      maxLines: 6, // limite de linhas (ajuste conforme desejar)
      minFontSize: 10, // menor tamanho permitido
      maxFontSize: 18, // tamanho inicial / máximo
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget _qrCode(String data) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 0.0),
    child: QrImageView(
      data: data, //userCard.id,
      version: QrVersions.auto,
      size: 160,
      backgroundColor: Colors.white,
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
          icon: const Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
          onPressed: () {
            final Uri url = Uri.parse(
              "https://wa.me/${userCard.card.store.contacts.phone}?text=Olá!",
            );
            _launchUrl(url);
          },
        ),
      ),
      Visibility(
        visible: true,
        child: IconButton(
          icon: const Icon(FontAwesomeIcons.instagram, color: Colors.white),
          onPressed: () async {
            final Uri nativeUrl = Uri.parse(
              "instagram://user?username=${userCard.card.store.contacts.instagram}",
            );
            final Uri webUrl = Uri.parse(
              "https://www.instagram.com/${userCard.card.store.contacts.instagram}/",
            );
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
          icon: const Icon(Icons.phone, color: Colors.white),
          onPressed: () {
            final Uri launchUri = Uri(scheme: 'tel', path: '+5581996509220');
            _launchUrl(launchUri);
          },
        ),
      ),
      Visibility(
        visible: true,
        child: IconButton(
          icon: const Icon(FontAwesomeIcons.globe, color: Colors.white),
          onPressed: () {
            final Uri url = Uri.parse(userCard.card.store.contacts.site!);
            _launchUrl(url);
          },
        ),
      ),
    ],
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
            "${userCard.points.length}/${userCard.reward.pointsRequired}",
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
            itemBuilder: (ctx) => [],
          ),
        ),
      ],
    ),
  );
}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
