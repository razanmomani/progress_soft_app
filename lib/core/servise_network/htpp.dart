import 'dart:convert';

import 'package:http/http.dart' as http;

class AHttpHelper {
  static const String baseUrl = "";

  static Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    return _handleResponse(response);
  }

  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      final decodedBody = json.decode(response.body);
      if (decodedBody is List) {
        return decodedBody;
      } else if (decodedBody is Map) {
        return decodedBody;
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
