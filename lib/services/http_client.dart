import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sehati_mobile/core/constants.dart';
import 'storage_service.dart';

class HttpClient {
  final http.Client _client = http.Client();

  Future<Map<String, String>> _getHeaders({bool includeAuth = true}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (includeAuth) {
      final token = await StorageService.getToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  Future<dynamic> get(String endpoint, {bool includeAuth = true}) async {
    try {
      final headers = await _getHeaders(includeAuth: includeAuth);
      final response = await _client
          .get(
            Uri.parse(endpoint),
            headers: headers,
          )
          .timeout(
            const Duration(milliseconds: AppConstants.connectionTimeout),
          );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<dynamic> post(String endpoint, {required Map<String, dynamic> body, bool includeAuth = true}) async {
    try {
      final headers = await _getHeaders(includeAuth: includeAuth);
      final response = await _client
          .post(
            Uri.parse(endpoint),
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(milliseconds: AppConstants.connectionTimeout),
          );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  Future<dynamic> put(String endpoint, {required Map<String, dynamic> body, bool includeAuth = true}) async {
    try {
      final headers = await _getHeaders(includeAuth: includeAuth);
      final response = await _client
          .put(
            Uri.parse(endpoint),
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(milliseconds: AppConstants.connectionTimeout),
          );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  Future<dynamic> delete(String endpoint, {bool includeAuth = true}) async {
    try {
      final headers = await _getHeaders(includeAuth: includeAuth);
      final response = await _client
          .delete(
            Uri.parse(endpoint),
            headers: headers,
          )
          .timeout(
            const Duration(milliseconds: AppConstants.connectionTimeout),
          );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Success
      if (response.body.isEmpty) {
        return {'success': true};
      }
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      // Unauthorized - token might be expired
      throw Exception('Unauthorized. Please login again.');
    } else if (response.statusCode == 403) {
      throw Exception('Forbidden. You do not have permission.');
    } else if (response.statusCode == 404) {
      throw Exception('Not found.');
    } else if (response.statusCode == 500) {
      throw Exception('Server error. Please try again later.');
    } else {
      // Other errors
      final errorBody = jsonDecode(response.body);
      throw Exception(errorBody['message'] ?? 'Unknown error occurred');
    }
  }

  void dispose() {
    _client.close();
  }
}
