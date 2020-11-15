import 'package:http_client/http_client.dart' as http;

class MyServiceClient {
  final http.Client httpClient;
  MyServiceClient(this.httpClient);
}