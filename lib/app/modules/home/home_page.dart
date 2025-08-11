import 'package:fidelin_user_app/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/pages/cards_page.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedPageIndex;
  late List<Widget> _pages;
  late PageController _pageController;

  final HomeController _qrController = Modular.get<HomeController>();

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = 0;
    _pages = [CardsPage(), const ProfilePage()];

    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: _scrollHandler,
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  // Future<void> _scanQR() async {
  //   String barcodeScanRes;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', 'Cancel', true, ScanMode.QR);

  //     final command = barcodeScanRes.split('/')[0];
  //     final value = barcodeScanRes.split('/')[1];

  //     switch (command) {
  //       case 'ADD_CARD':
  //         _qrController.addCard('7d7d1c5a-2766-428c-a87b-016831becc26');
  //         break;
  //       case 'ADD_POINT':
  //         _qrController.addPoint("03e65819-28ab-4d3c-8cbf-4203ea526ae8");
  //         break;
  //       default:
  //         break;
  //     }

  //     print(barcodeScanRes);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  // }

  void _tapHandler(int index) {
    setState(() {
      _selectedPageIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    });
  }

  void _scrollHandler(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget bottomNavigationBar() {
    return AnimatedBuilder(
      animation: _pageController,
      builder:
          (context, snapshot) => Container(
            color: Colors.white,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => _tapHandler(0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 8,
                    ),
                    child: Icon(
                      Icons.home,
                      color:
                          _selectedPageIndex == 0
                              ? Theme.of(context).colorScheme.primary
                              : Colors.black45,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    // final result = await Navigator.of(context).push<String>(
                    //   MaterialPageRoute(builder: (_) => const QRScannerPage()),
                    // );

                    Modular.to.pushNamed('/home/qr'); // correto

                    // if (result != null) {
                    //   final command = result.split('/')[0];
                    //   final value = result.split('/')[1];

                    //   switch (command) {
                    //     case 'ADD_CARD':
                    //       _qrController.addCard(value);
                    //       break;
                    //     case 'ADD_POINT':
                    //       _qrController.addPoint(value);
                    //       break;
                    //     default:
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         const SnackBar(content: Text('QR Code inválido')),
                    //       );
                    //       break;
                    //   }
                    // }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xFFFF00D6), Color(0xFFFF4D00)],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 12,
                    ),
                    child: const Icon(Icons.qr_code, color: Colors.white),
                  ),
                ),
                InkWell(
                  onTap: () => _tapHandler(1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 8,
                    ),
                    child: Icon(
                      Icons.person,
                      color:
                          _selectedPageIndex == 1
                              ? Theme.of(context).colorScheme.primary
                              : Colors.black45,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
