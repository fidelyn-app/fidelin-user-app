import 'dart:math' as math;

import 'package:fidelin_user_app/app/modules/home/domain/entities/user_card_entity.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/widgets/point_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
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

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  final HomeController _homeController = Modular.get<HomeController>();

  late UserCard userCard;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    userCard = _homeController.cards[widget.index];

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCard() {
    if (_controller.isAnimating) return;
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidget = widget.constraints.maxWidth / 1.30;

    // GestureDetector envolve a animação para captar toques e virar o cartão
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _toggleCard,
      child: SizedBox(
        width: cardWidget,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final angle = _animation.value * math.pi; // 0 -> pi
            // true: mostra frente ; false: mostra verso
            final isFront = angle <= (math.pi / 2);

            // Matriz 3D para efeito de profundidade
            final transform =
                Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // perspectiva
                  ..rotateY(angle);

            return Transform(
              transform: transform,
              alignment: Alignment.center,
              child:
                  isFront
                      ? _buildFront(cardWidget)
                      : Transform(
                        transform: Matrix4.identity()..rotateY(math.pi),
                        alignment: Alignment.center,
                        child: _buildBack(cardWidget),
                      ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFront(double width) {
    final backgroundUrl = userCard.card.style.backgroundUrl;

    Widget backgroundWidget;

    if (backgroundUrl != null) {
      if (backgroundUrl.toLowerCase().endsWith('.json')) {
        // Lottie animation
        backgroundWidget = Positioned.fill(
          child: Lottie.network(backgroundUrl, fit: BoxFit.cover, repeat: true),
        );
      } else {
        // Image (png, jpeg, etc)
        backgroundWidget = Positioned.fill(
          child: Image.network(backgroundUrl, fit: BoxFit.cover),
        );
      }
    } else {
      // Fallback: cor de fundo
      backgroundWidget = Container(color: userCard.card.style.backgroundColor);
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
                _bottom(userCard),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBack(double width) {
    final backgroundUrl = userCard.card.style.backgroundUrl;

    Widget backgroundWidget;

    if (backgroundUrl != null) {
      if (backgroundUrl.toLowerCase().endsWith('.json')) {
        // Lottie animation
        backgroundWidget = Positioned.fill(
          child: Lottie.network(backgroundUrl, fit: BoxFit.cover, repeat: true),
        );
      } else {
        // Image (png, jpeg, etc)
        backgroundWidget = Positioned.fill(
          child: Image.network(backgroundUrl, fit: BoxFit.cover),
        );
      }
    } else {
      // Fallback: cor de fundo
      backgroundWidget = Container(
        color:
            userCard.card.style.backgroundColor?.withOpacity(0.95) ??
            Colors.black87,
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
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Cabeçalho simplificado no verso
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 32),
                      Text(
                        "Cartão",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          MdiIcons.qrcode,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () => _dialogQRCode(context, userCard),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // QR inline
                  QrImageView(
                    data: userCard.id,
                    version: QrVersions.auto,
                    size: 140,
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userCard.card.description,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  if (userCard.card.store.contacts.phone != null)
                    Text(
                      "Tel: ${userCard.card.store.contacts.phone}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  const SizedBox(height: 8),
                  // Botões rápidos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          final Uri url = Uri.parse(
                            "https://wa.me/${userCard.card.store.contacts.phone}?text=Olá!",
                          );
                          _launchUrl(url);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.instagram,
                          color: Colors.white,
                        ),
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
                      IconButton(
                        icon: const Icon(Icons.phone, color: Colors.white),
                        onPressed: () {
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: '+5581996509220',
                          );
                          _launchUrl(launchUri);
                        },
                      ),
                    ],
                  ),
                ],
              ),
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
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      PopupMenuButton(
        icon: Icon(MdiIcons.dotsVertical, color: Colors.white, size: 32),
        itemBuilder: (ctx) => [_buildPopupMenuItem('Excluir')],
      ),
      Text(
        "${userCard.points.length}/${userCard.card.maxPoints}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      IconButton(
        icon: Icon(MdiIcons.qrcode, color: Colors.white, size: 32),
        onPressed: () => _dialogQRCode(context, userCard),
      ),
    ],
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

PopupMenuItem _buildPopupMenuItem(String title) {
  return PopupMenuItem(child: Text(title));
}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
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
              const SizedBox(height: 10.0),
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
