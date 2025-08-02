import 'package:fidelin_user_app/app/core/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  bool get wantKeepAlive => true;
  final UserStore _userStore = Modular.get<UserStore>();

  double picSize = 60.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LayoutBuilder(
        builder:
            (BuildContext context, BoxConstraints constraints) => Stack(
              children: [
                Container(
                  height: constraints.maxWidth / 2.5,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/fidelin-b1ad0.appspot.com/o/cards%2F2.png?alt=media&token=eec7dc73-898a-4eac-b244-1a90dd7d95d8",
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: constraints.maxWidth / 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: picSize + 20),
                      Text(
                        _userStore.user!.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22.0),
                      ),
                      Text(_userStore.user!.email, textAlign: TextAlign.center),
                      Expanded(
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Visibility(
                              visible: false,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: ListTile(
                                  onTap: () {},
                                  leading: const Icon(Icons.person),
                                  title: const Text('Editar Perfil'),
                                ),
                              ),
                            ),
                            const Divider(height: 0),
                            const Visibility(
                              visible: false,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: ListTile(
                                  leading: Icon(Icons.lock),
                                  title: Text('Mudar Senha'),
                                ),
                              ),
                            ),
                            const Divider(height: 1),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: ListTile(
                                leading: const Icon(Icons.logout),
                                title: const Text('Sair'),
                                onTap: () {
                                  _userStore.removeUser();
                                  Modular.to.pushNamedAndRemoveUntil(
                                    "/auth/",
                                    (_) => false,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Positioned(
                  top: constraints.maxWidth / 5,
                  left: constraints.maxWidth / 2 - picSize,
                  child: CircleAvatar(
                    radius: picSize,
                    backgroundColor: Colors.black12,
                    child:
                        _userStore.user!.avatarUrl != null
                            ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: picSize - 2,
                              backgroundImage: NetworkImage(
                                _userStore.user!.avatarUrl!,
                              ),
                            )
                            : CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: picSize - 2,
                              child: const Icon(
                                Icons.person,
                                size: 64,
                                color: Colors.black26,
                              ),
                            ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
