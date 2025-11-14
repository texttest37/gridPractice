import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/environment.dart';
import '../utils/logger.dart';

class ApiService {
  String get baseUrl => Environment.apiBaseUrl;
  Duration get timeout => Environment.apiTimeout;

  Future<dynamic> get(String endpoint) async {
    try {
      Logger.debug('GET Request: $baseUrl$endpoint');

      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(timeout);

      Logger.debug('GET Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final error = 'Failed to load data: ${response.statusCode}';
        Logger.error(error);
        throw Exception(error);
      }
    } catch (e) {
      final error = 'Network error: $e';
      Logger.error(error, error: e);
      throw Exception(error);
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      Logger.debug('POST Request: $baseUrl$endpoint');
      Logger.debug('POST Data: $data');

      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      ).timeout(timeout);

      Logger.debug('POST Response: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        final error = 'Failed to post data: ${response.statusCode}';
        Logger.error(error);
        throw Exception(error);
      }
    } catch (e) {
      final error = 'Network error: $e';
      Logger.error(error, error: e);
      throw Exception(error);
    }
  }
}