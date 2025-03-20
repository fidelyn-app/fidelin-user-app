import 'package:fidelin_user_app/app/core/services/shared_local_storage_service.dart';
import 'package:fidelin_user_app/app/core/stores/user_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'services/http_client.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton(Logger.new);
    i.addSingleton(http.Client.new);
    i.addSingleton(() => HttpClient(i.get<http.Client>(), i.get<Logger>()));

    i.addSingleton(() => SharedLocalStorageService());
    i.addSingleton(UserStore.new);
  }
}
