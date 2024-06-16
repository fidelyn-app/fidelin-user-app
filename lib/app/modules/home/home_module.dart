import 'package:fidelin_user_app/app/modules/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomePage(), children: [
      ChildRoute('/page1',
          child: (context) =>
              const InternalPage(title: 'page 1', color: Colors.red)),
      ChildRoute('/page2',
          child: (context) =>
              const InternalPage(title: 'page 2', color: Colors.amber)),
      ChildRoute('/page3',
          child: (context) =>
              const InternalPage(title: 'page 3', color: Colors.green)),
    ]);
  }
}
