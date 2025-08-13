import 'package:fidelin_user_app/app/core/stores/app_store.dart';
import 'package:fidelin_user_app/app/modules/home/presentation/mixins/home_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with HomeMixin, AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  bool get wantKeepAlive => true;
  final AppStore _userStore = Modular.get<AppStore>();

  double picSize = 60.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LayoutBuilder(
        builder:
            (BuildContext context, BoxConstraints constraints) => Container(
              margin: EdgeInsets.only(top: constraints.maxWidth / 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(2), // espessura da "borda"
                      decoration: BoxDecoration(
                        color: Colors.grey, // cor da borda
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: picSize,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 64,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _userStore.user!.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
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

                          Visibility(
                            visible: true,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: ListTile(
                                onTap: () async {
                                  final result = await Modular.to
                                      .pushNamed<bool>('/auth/forgot-password');
                                },
                                leading: Icon(Icons.lock),
                                title: Text('Mudar Senha'),
                              ),
                            ),
                          ),
                          const Divider(height: 1),
                          Visibility(
                            visible: true,
                            child: Padding(
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
                          ),
                          Visibility(
                            visible: false,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await _userStore.removeUser();
                                Modular.to.pushNamedAndRemoveUntil(
                                  "/auth/",
                                  (_) => false,
                                );
                              },
                              icon: Icon(
                                Icons.logout,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              label: Text(
                                "Sair",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(child: Text(appStore.appVersion!)),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
