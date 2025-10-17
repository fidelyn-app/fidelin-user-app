import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

class HttpClient extends BaseClient {
  final Client _delegate;
  final Logger _logger;

  HttpClient(this._delegate, this._logger);

  @override
  void close() {
    _delegate.close();
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    String s = "⬆️ REQUEST: ${request.method} ${request.url}";
    s += "\nheader: ${request.headers}";
    if (request is Request && request.body.length > 0) {
      s += "\nbody: ${request.body}";
    }
    _logger.d(s);
    final response = await _delegate.send(request);
    s = "⬇️ RESPONSE: ${request.method} ${request.url}";
    s += "\nheader: ${response.headers}";

    if (request is Request) {
      final List<int> bytes = await response.stream.toBytes();
      s += "\nbody: ${utf8.decode(bytes)}";
      _logger.d(s);

      return StreamedResponse(
        ByteStream.fromBytes(bytes),
        response.statusCode,
        contentLength: response.contentLength,
        request: request,
        headers: response.headers,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
        reasonPhrase: response.reasonPhrase,
      );
    }

    _logger.d(s);

    return response;
  }
}
