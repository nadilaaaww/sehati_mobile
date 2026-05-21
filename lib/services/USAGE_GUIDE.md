/// Network & Authentication Services - Usage Guide
/// 
/// This file demonstrates how to use the network client and authentication services
/// in your SEHATI mobile app.

// ============================================================================
// EXAMPLE 1: Login with Email and Password
// ============================================================================

/*
import 'package:sehati_mobile/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> handleLogin() async {
    setState(() => isLoading = true);

    final result = await _authService.login(
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() => isLoading = false);

    if (result['success']) {
      // Navigate to home screen
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Show error message
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
    // Your login form UI here
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: // ... form with email and password fields
    );
  }
}
*/

// ============================================================================
// EXAMPLE 2: Register New User
// ============================================================================

/*
import 'package:sehati_mobile/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();
  
  Future<void> handleRegister() async {
    final result = await _authService.register(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      passwordConfirmation: confirmPasswordController.text,
    );

    if (result['success']) {
      // Show success message and navigate to login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful! Please login.')),
      );
      Navigator.pushReplacementNamed(context, '/login');
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
    // Your registration form UI here
    return Scaffold();
  }
}
*/

// ============================================================================
// EXAMPLE 3: Check if User is Logged In (Splash/Init Screen)
// ============================================================================

/*
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
      // Navigate to home screen
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Navigate to login screen
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
*/

// ============================================================================
// EXAMPLE 4: Logout User
// ============================================================================

/*
import 'package:sehati_mobile/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();

  Future<void> handleLogout() async {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _authService.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _authService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: ElevatedButton(
          onPressed: handleLogout,
          child: Text('Logout'),
        ),
      ),
    );
  }
}
*/

// ============================================================================
// EXAMPLE 5: Using StorageService Directly
// ============================================================================

/*
import 'package:sehati_mobile/services/storage_service.dart';

// Get saved token
String? token = await StorageService.getToken();

// Get user info
String? userName = await StorageService.getUserName();
String? userEmail = await StorageService.getUserEmail();
String? userId = await StorageService.getUserId();

// Check if user is logged in
bool isLoggedIn = await StorageService.isLoggedIn();

// Clear all data (logout)
await StorageService.clearAll();
*/

// ============================================================================
// EXAMPLE 6: Making HTTP Requests with HttpClient
// ============================================================================

/*
import 'package:sehati_mobile/services/http_client.dart';
import 'package:sehati_mobile/core/constants.dart';

final httpClient = HttpClient();

// GET request
try {
  final doctors = await httpClient.get(AppConstants.doctorEndpoint);
  print('Doctors: $doctors');
} catch (e) {
  print('Error: $e');
}

// POST request
try {
  final bookingResponse = await httpClient.post(
    AppConstants.bookingEndpoint,
    body: {
      'doctor_id': 123,
      'date': '2026-05-20',
      'time': '10:00',
    },
  );
  print('Booking created: $bookingResponse');
} catch (e) {
  print('Error: $e');
}

// PUT request (update)
try {
  final updated = await httpClient.put(
    '${AppConstants.baseUrl}/doctor/123',
    body: {'name': 'Dr. Updated Name'},
  );
  print('Updated: $updated');
} catch (e) {
  print('Error: $e');
}

// DELETE request
try {
  await httpClient.delete('${AppConstants.baseUrl}/booking/123');
  print('Booking deleted');
} catch (e) {
  print('Error: $e');
}

httpClient.dispose();
*/

// ============================================================================
// KEY FEATURES
// ============================================================================

/*
1. STORAGE SERVICE (storage_service.dart):
   - saveToken(token) - Save auth token securely
   - getToken() - Retrieve token
   - deleteToken() - Remove token
   - saveUserId/Email/Name() - Save user data
   - getUserId/Email/Name() - Retrieve user data
   - isLoggedIn() - Check authentication status
   - clearAll() - Logout and clear all data

2. HTTP CLIENT (http_client.dart):
   - get() - Make GET requests
   - post() - Make POST requests
   - put() - Make PUT requests
   - delete() - Make DELETE requests
   - Automatic token injection in Authorization header
   - Error handling with proper HTTP status codes
   - Timeout handling (30 seconds default)

3. AUTH SERVICE (auth_service.dart):
   - login() - Authenticate user
   - register() - Create new account
   - logout() - End session
   - isLoggedIn() - Check authentication
   - getCurrentUser() - Fetch user profile
   - updateProfile() - Update user info

4. CONSTANTS (core/constants.dart):
   - baseUrl - API base URL
   - API endpoints (login, register, doctor, booking, etc.)
   - Timeout configuration
   - App information
*/
