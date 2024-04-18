import 'package:http/http.dart';
import '../main.dart';

class CustomHttpClient extends BaseClient {
  final _client = Client();
  final String overrideHost;

  CustomHttpClient({required this.overrideHost});

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    if (request is! Request ||
        request.url.host != 'generativelanguage.googleapis.com') {
      return _client.send(request);
    }

    var overrideUrlString = request.url.toString().replaceAll(
          'https://generativelanguage.googleapis.com',
          overrideHost,
        );

    overrideUrlString = overrideUrlString;
    var overrideRequest = Request(
      request.method,
      Uri.parse(overrideUrlString),
    )
      ..bodyBytes = request.bodyBytes;
    overrideRequest.headers.addAll(request.headers);

    return _client.send(overrideRequest);
  }
}
