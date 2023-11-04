import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginConnection {
  Future<List<dynamic>?> login(Map body) async {
    try {
      final String email= body['email'];
      final String password = body['password'];
      final http.Response response = await http.get(
        Uri.parse(
            'http://10.0.2.2:3000/users?email=$email&password=$password'), // Substitua com a URL correta
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred during login: $e');
    }
    return null;
  }
}
