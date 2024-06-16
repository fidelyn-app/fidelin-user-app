import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Modular.to.navigate('/home/page1');
  }

  @override
  Widget build(BuildContext context) {
    final leading = SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Column(
        children: [
          ListTile(
            title: const Text('Page 1'),
            onTap: () => Modular.to.navigate('/home/page1'),
          ),
          ListTile(
            title: const Text('Page 2'),
            onTap: () => Modular.to.navigate('/home/page2'),
          ),
          ListTile(
            title: const Text('Page 3'),
            onTap: () => Modular.to.navigate('/home/page3'),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Row(
        children: [
          leading,
          Container(width: 2, color: Colors.black45),
          const Expanded(child: RouterOutlet()),
        ],
      ),
    );
  }
}

class InternalPage extends StatefulWidget {
  final String title;
  final Color color;
  const InternalPage({super.key, required this.title, required this.color});

  @override
  State<InternalPage> createState() => _InternalPageState();
}

class _InternalPageState extends State<InternalPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('INIT: ${widget.title}');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color,
      child: Center(child: Text(widget.title)),
    );
  }
}
