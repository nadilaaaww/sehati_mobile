# Network & Authentication Architecture - SEHATI Mobile

## Overview

This document describes the network client and authentication system implemented for the SEHATI mobile app.

## Project Structure

```
lib/
├── core/
│   └── constants.dart          # Centralized API configuration
├── services/
│   ├── http_client.dart        # HTTP client for API requests
│   ├── storage_service.dart    # Local storage management
│   ├── auth_service.dart       # Authentication logic
│   └── USAGE_GUIDE.md          # Usage examples
└── screens/
    ├── splash_screen.dart
    ├── login_screen.dart
    └── ... (other screens)
```

## Key Components

### 1. **AppConstants** (`lib/core/constants.dart`)

Centralized configuration for all API endpoints and app settings.

**Features:**
- Single base URL: `http://103.157.27.240:8000/api`
- Pre-defined endpoints (login, register, doctor, booking, etc.)
- Timeout configurations (30 seconds)
- App metadata (name, version, clinic name)

**Benefits:**
- Easy to switch between dev/production URLs
- No hardcoded IPs in screens
- Maintainable and organized

---

### 2. **HttpClient** (`lib/services/http_client.dart`)

Low-level HTTP communication client.

**Features:**
- Support for GET, POST, PUT, DELETE requests
- Automatic authentication token injection
- Error handling with meaningful messages
- Request/response timeout management
- JSON serialization/deserialization

**Methods:**
```dart
Future<dynamic> get(String endpoint, {bool includeAuth = true})
Future<dynamic> post(String endpoint, {required Map<String, dynamic> body, bool includeAuth = true})
Future<dynamic> put(String endpoint, {required Map<String, dynamic> body, bool includeAuth = true})
Future<dynamic> delete(String endpoint, {bool includeAuth = true})
```

**Error Handling:**
- 2xx: Success
- 401: Unauthorized (token expired/invalid)
- 403: Forbidden (permission denied)
- 404: Not found
- 500: Server error
- Other: Custom error messages from server

---

### 3. **StorageService** (`lib/services/storage_service.dart`)

Local data persistence management.

**Uses Two Storage Methods:**
1. **FlutterSecureStorage** - For sensitive data (tokens)
   - Encrypted storage
   - Secure by design
   
2. **SharedPreferences** - For non-sensitive data (user info)
   - Fast access
   - Sufficient for public data

**Methods:**
```dart
// Token management
Future<void> saveToken(String token)
Future<String?> getToken()
Future<void> deleteToken()

// User data
Future<void> saveUserId/Email/Name(String data)
Future<String?> getUserId/Email/Name()

// Authentication state
Future<bool> isLoggedIn()
Future<void> clearAll()  // Logout
```

---

### 4. **AuthService** (`lib/services/auth_service.dart`)

High-level authentication logic.

**Features:**
- User login with email/password
- User registration
- Profile updates
- Logout with cleanup
- Automatic token storage
- User data caching

**Methods:**
```dart
Future<Map<String, dynamic>> login({
  required String email,
  required String password,
})

Future<Map<String, dynamic>> register({
  required String name,
  required String email,
  required String password,
  required String passwordConfirmation,
})

Future<void> logout()
Future<bool> isLoggedIn()
Future<Map<String, dynamic>?> getCurrentUser()
Future<Map<String, dynamic>> updateProfile({
  required String name,
  required String email,
})
```

---

## Data Flow

### Login Flow

```
User Input (email, password)
         ↓
   AuthService.login()
         ↓
   HttpClient.post() → API
         ↓
   Parse Response
         ↓
   Extract Token & User Data
         ↓
   StorageService.saveToken()
   StorageService.saveUserData()
         ↓
   Return Success ✓
         ↓
   Navigate to Home
```

### Authenticated Request Flow

```
Screen needs data
         ↓
   HttpClient.get/post/put/delete()
         ↓
   StorageService.getToken()
         ↓
   Add "Authorization: Bearer {token}" header
         ↓
   Send HTTP Request
         ↓
   Get Response
         ↓
   Return Data or Error
```

### Logout Flow

```
User clicks Logout
         ↓
   AuthService.logout()
         ↓
   HttpClient.post() → /logout (optional)
         ↓
   StorageService.clearAll()
         ↓
   Delete Token
   Delete User Data
         ↓
   Navigate to Login
```

---

## Implementation Guide

### Step 1: Install Dependencies

Already done! The following packages are added to `pubspec.yaml`:
- `http: ^1.1.0` - HTTP client
- `shared_preferences: ^2.2.2` - Local storage
- `flutter_secure_storage: ^9.0.0` - Secure storage

### Step 2: Use in Login Screen

```dart
import 'package:sehati_mobile/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  
  Future<void> handleLogin() async {
    final result = await _authService.login(
      email: emailController.text,
      password: passwordController.text,
    );

    if (result['success']) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
    }
  }

  @override
  void dispose() {
    _authService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Your login UI
    return Scaffold();
  }
}
```

### Step 3: Use in Splash/Init Screen

```dart
import 'package:sehati_mobile/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2));
    
    final isLoggedIn = await _authService.isLoggedIn();
    
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void dispose() {
    _authService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
```

### Step 4: Make API Calls from Screens

```dart
import 'package:sehati_mobile/services/http_client.dart';
import 'package:sehati_mobile/core/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HttpClient _httpClient = HttpClient();
  List<dynamic> doctors = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    try {
      setState(() => isLoading = true);
      final response = await _httpClient.get(AppConstants.doctorEndpoint);
      setState(() {
        doctors = response['data'] ?? [];
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void dispose() {
    _httpClient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doctors')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return ListTile(
                  title: Text(doctor['name']),
                  subtitle: Text(doctor['specialty']),
                );
              },
            ),
    );
  }
}
```

---

## Security Considerations

### ✅ What's Secured

1. **Authentication Tokens**
   - Stored in encrypted `FlutterSecureStorage`
   - Not accessible to other apps
   - Automatically cleared on logout

2. **HTTP Headers**
   - Token injected as `Authorization: Bearer {token}`
   - Sent only with authenticated requests
   - Not included in registration/login requests

3. **Data Validation**
   - HTTP status codes checked
   - 401 responses indicate session expiration
   - Error messages from server displayed

### ⚠️ Important Notes

1. **Use HTTPS in Production**
   - Current config uses HTTP for development
   - Update to HTTPS (`https://...`) for production
   - Modify `android:usesCleartextTraffic="true"` accordingly

2. **API Endpoints**
   - Never commit `.env` files with real credentials
   - Use environment variables for sensitive data
   - Consider using a dedicated secrets management solution

3. **Token Refresh**
   - Current implementation doesn't refresh tokens
   - Consider adding token refresh logic if needed
   - Handle 401 responses with automatic re-login

---

## Common Tasks

### 1. Adding a New API Endpoint

```dart
// In lib/core/constants.dart
static const String newEndpoint = '$baseUrl/new-endpoint';
```

### 2. Making an API Call

```dart
final httpClient = HttpClient();
final response = await httpClient.get(AppConstants.newEndpoint);
httpClient.dispose();
```

### 3. Handling Errors

```dart
try {
  final response = await httpClient.post(
    AppConstants.loginEndpoint,
    body: {'email': email, 'password': password},
    includeAuth: false,
  );
} catch (e) {
  print('Error: $e');
  // Show user-friendly error message
}
```

### 4. Checking Authentication Status

```dart
final isLoggedIn = await StorageService.isLoggedIn();
if (isLoggedIn) {
  // User is authenticated
}
```

### 5. Logout User

```dart
final authService = AuthService();
await authService.logout();
Navigator.pushReplacementNamed(context, '/login');
```

---

## Troubleshooting

### Issue: "Unauthorized" Error After Login

**Cause:** Token might not be saved correctly

**Solution:**
1. Check API response format matches expectations
2. Verify token is under `response['data']['token']` or `response['token']`
3. Add debug logging to see actual response

### Issue: CORS Errors on Web

**Cause:** Backend not configured for CORS

**Solution:**
1. Add CORS headers to Laravel backend
2. Configure allowed origins to include web domain
3. Test with Chrome DevTools Network tab

### Issue: Network Request Timeout

**Cause:** Slow network or unresponsive server

**Solution:**
1. Increase timeout in `AppConstants.connectionTimeout`
2. Check server is running and accessible
3. Test with Postman before using in app

### Issue: Token Not Being Sent

**Cause:** Using `includeAuth: false` accidentally

**Solution:**
1. Remove or set `includeAuth: true` for authenticated endpoints
2. Check token is saved with `StorageService.getToken()`
3. Verify API expects `Authorization` header

---

## Next Steps

1. ✅ Update login screen to use `AuthService`
2. ✅ Update registration screen to use `AuthService`
3. ✅ Update all screens that need API data to use `HttpClient`
4. ✅ Add logout functionality to profile screen
5. ✅ Handle token refresh for long sessions
6. ✅ Add loading states and error handling to all screens
7. ✅ Test with real API endpoints
8. ✅ Switch to HTTPS for production

---

## References

- [Flutter HTTP Package](https://pub.dev/packages/http)
- [SharedPreferences](https://pub.dev/packages/shared_preferences)
- [FlutterSecureStorage](https://pub.dev/packages/flutter_secure_storage)
- [Dart Async Programming](https://dart.dev/guides/language/language-tour#asynchrony-support)
