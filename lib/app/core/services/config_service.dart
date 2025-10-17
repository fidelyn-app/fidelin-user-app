import 'package:configcat_client/configcat_client.dart';

class ConfigService {
  final ConfigCatClient _client;
  ConfigService(this._client);

  Future<bool> isFeatureOn(String key) async {
    return await _client.getValue<bool>(key: key, defaultValue: false);
  }
}
