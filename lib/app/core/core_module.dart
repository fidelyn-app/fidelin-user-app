import 'package:configcat_client/configcat_client.dart';
import 'package:fidelyn_user_app/app/core/services/config_service.dart';
import 'package:fidelyn_user_app/app/core/services/shared_local_storage_service.dart';
import 'package:fidelyn_user_app/app/core/stores/app_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fidelyn_user_app/env.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart' as L;

import 'services/http_client.dart';

class CoreModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(() => ConfigCatClient.get(sdkKey: Env.configCatKey));
    i.addSingleton(() => ConfigService(i.get<ConfigCatClient>()));

    i.addSingleton(L.Logger.new);
    i.addSingleton(http.Client.new);
    i.addSingleton(() => HttpClient(i.get<http.Client>(), i.get<L.Logger>()));

    i.addSingleton(() => SharedLocalStorageService());
    i.addSingleton(AppStore.new);
  }
}
