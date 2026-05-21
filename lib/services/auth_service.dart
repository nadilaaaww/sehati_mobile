import 'package:sehati_mobile/core/constants.dart';
import 'http_client.dart';
import 'storage_service.dart';

class AuthService {
  final HttpClient _httpClient = HttpClient();

  /// Login user with email and password
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _httpClient.post(
        AppConstants.loginEndpoint,
        body: {
          'email': email,
          'password': password,
        },
        includeAuth: false,
      );

      if (response['success'] == true || response['status'] == 'success') {
        // Extract token and user data
        final token = response['data']['token'] ?? response['token'];
        final userData = response['data']['user'] ?? response['user'];

        // Save token securely
        await StorageService.saveToken(token);

        // Save user info
        if (userData != null) {
          await StorageService.saveUserId(userData['id'].toString());
          await StorageService.saveUserEmail(userData['email'] ?? '');
          await StorageService.saveUserName(userData['name'] ?? '');
        }

        return {
          'success': true,
          'message': 'Login successful',
          'token': token,
          'user': userData,
        };
      } else {
        return {
          'success': false,
          'message': response['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  /// Register new user
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _httpClient.post(
        AppConstants.registerEndpoint,
        body: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
        includeAuth: false,
      );

      if (response['success'] == true || response['status'] == 'success') {
        return {
          'success': true,
          'message': response['message'] ?? 'Registration successful',
          'data': response['data'],
        };
      } else {
        return {
          'success': false,
          'message': response['message'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      await _httpClient.post(
        '${AppConstants.baseUrl}/mobile/logout',
        body: {},
      );
    } catch (e) {
      // Even if API call fails, clear local storage
      print('Logout API error: $e');
    } finally {
      // Clear all stored data
      await StorageService.clearAll();
    }
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    return await StorageService.isLoggedIn();
  }

  /// Get current user info
  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final response = await _httpClient.get(AppConstants.userEndpoint);
      if (response['success'] == true || response['status'] == 'success') {
        return response['data'] ?? response['user'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Update user profile
  Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String email,
  }) async {
    try {
      final response = await _httpClient.put(
        AppConstants.userEndpoint,
        body: {
          'name': name,
          'email': email,
        },
      );

      if (response['success'] == true || response['status'] == 'success') {
        // Update local storage
        await StorageService.saveUserName(name);
        await StorageService.saveUserEmail(email);

        return {
          'success': true,
          'message': response['message'] ?? 'Profile updated successfully',
          'data': response['data'],
        };
      } else {
        return {
          'success': false,
          'message': response['message'] ?? 'Update failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  void dispose() {
    _httpClient.dispose();
  }
}
