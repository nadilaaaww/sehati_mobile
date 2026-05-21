class AppConstants {
  // API Configuration
  static const String baseUrl = 'http://103.157.27.240:8000/api';

  // API Endpoints
  static const String loginEndpoint = '$baseUrl/mobile/login';
  static const String registerEndpoint = '$baseUrl/register';
  static const String dashboardEndpoint = '/mobile/dashboard';
  static const String userEndpoint = '$baseUrl/user';
  static const String doctorEndpoint = '$baseUrl/doctor';
  static const String bookingEndpoint = '$baseUrl/booking';
  static const String visitHistoryEndpoint = '$baseUrl/visit-history';
  static const String medicineEndpoint = '$baseUrl/medicine';
  static const String notificationEndpoint = '$baseUrl/notification';

  // Timeout configurations
  static const int connectionTimeout = 30000; // in milliseconds
  static const int receiveTimeout = 30000; // in milliseconds

  // App Information
  static const String appName = 'SEHATI';
  static const String appVersion = '1.0.0';
  static const String clinicName = 'Klinik Sehati Jember';
}
