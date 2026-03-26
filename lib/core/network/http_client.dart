import 'dart:convert';
import 'package:flutter_shopping_app/core/constants/app_env.dart';
import 'package:http/http.dart' as http;

class AppHttpClient {
  String get baseUrl => AppEnv.apiBaseUrl;
  final http.Client _client;

  AppHttpClient({http.Client? client}) : _client = client ?? http.Client();

  Future<dynamic> get(String path) async {
    final response = await _client.get(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> patch(String path, Map<String, dynamic> body) async {
    final response = await _client.patch(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> delete(String path) async {
    final response = await _client.delete(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }
}
