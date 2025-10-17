// ignore_for_file: unnecessary_null_comparison

import 'package:fidelin_user_app/app/modules/home/domain/entities/user_card_entity.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/widgets/bottom_sheet_widget.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/widgets/card/point_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:math' as math;

class CardFront extends StatefulWidget {
  final UserCard userCard;
  final double width;

  const CardFront({super.key, required this.userCard, required this.width});

  @override
  State<CardFront> createState() => _CardFrontState();
}

class _CardFrontState extends State<CardFront>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animController;
  late final Animation<double> _bounceAnim;
  bool _showIndicator = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_updateIndicatorVisibility);

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _bounceAnim = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    _animController.repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _updateIndicatorVisibility(),
    );
  }

  void _updateIndicatorVisibility() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;

    final shouldShow = maxScroll > 2.0 && current < maxScroll - 2.0;

    if (shouldShow != _showIndicator && mounted) {
      setState(() => _showIndicator = shouldShow);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateIndicatorVisibility);
    _scrollController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundUrl = widget.userCard.card.style.backgroundUrl;
    final isCardActive = widget.userCard.card.active;

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
        color: widget.userCard.card.style.colorPrimary,
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: widget.width,
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
            Positioned.fill(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _header(widget.userCard, context),
                      _avatar(widget.userCard),
                      _titleAndSubtitle(widget.userCard),
                      _gridPoints(widget.userCard, context, _scrollController),
                    ],
                  ),

                  if (_showIndicator)
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: IgnorePointer(
                        ignoring: true,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _bounceAnim,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, -_bounceAnim.value),
                                child: Opacity(opacity: 0.95, child: child),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 36,
                                color:
                                    widget.userCard.card.style.colorPrimary !=
                                            null
                                        ? _contrastColor(
                                          widget
                                              .userCard
                                              .card
                                              .style
                                              .colorPrimary,
                                        )
                                        : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            !isCardActive ? foreground() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Color _contrastColor(Color bg) {
    final lum = bg.computeLuminance();
    return lum > 0.5 ? Colors.black : Colors.grey.shade300;
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
            itemBuilder:
                (ctx) => [_buildPopupMenuItem(context, 'Excluir', userCard.id)],
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
            radius: 42,
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

Widget _gridPoints(
  UserCard userCard,
  BuildContext context,
  ScrollController controller,
) {
  return Expanded(
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GridView.builder(
          controller: controller,
          primary: false,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          itemCount: userCard.reward.pointsRequired,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: 1,
          ),
          itemBuilder:
              (BuildContext context, int index) => PointWidget(
                selected: userCard.points.length > index,
                color: userCard.card.style.colorPrimary,
                isLastPoint: userCard.reward.pointsRequired - 1 == index,
                index: index + 1,
              ),
        );
      },
    ),
  );
}

PopupMenuItem _buildPopupMenuItem(
  BuildContext context,
  String title,
  String cardId,
) {
  final HomeController _homeController = Modular.get<HomeController>();

  return PopupMenuItem(
    child: Text(title),
    onTap: () {
      BottomSheetWidget.show(
        context,
        title: 'Excluir Cartão',
        message:
            'Você tem certeza que deseja excluir este cartão? Esta ação não pode ser desfeita.',
        confirmButtonText: 'Sim, Excluir',
        cancelButtonText: 'Não, Manter',
        onConfirm: () {
          _homeController.deleteCard(cardId: cardId);
          Navigator.of(context).pop(); // Fecha o bottom sheet
        },
      );
    },
  );
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
