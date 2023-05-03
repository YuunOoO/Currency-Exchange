import 'package:http/http.dart' as http;

class ApiService {
  Future<http.Response> makeApiGetRequest(String uri) async {
    return http.get(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
