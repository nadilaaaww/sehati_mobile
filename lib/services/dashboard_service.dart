import 'package:sehati_mobile/core/constants.dart';
import 'http_client.dart';
import 'models.dart';

class DashboardService {
  final HttpClient _httpClient = HttpClient();

  /// 🛠️ DIUBAH: Nama fungsi disamakan dengan home_screen.dart & rute diarahkan ke /mobile/dashboard
  Future<Map<String, dynamic>> getDashboardData() async {
    try {
      final response = await _httpClient.get(
        '/mobile/dashboard', // 💡 Mengetuk pintu rute mobile yang seragam
      );

      if (response['success'] == true || response['status'] == 'success') {
        return {
          'success': true,
          'data': response['data'] ?? {},
        };
      } else {
        return {
          'success': false,
          'message': response['message'] ?? 'Failed to fetch dashboard',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  /// Get user statistics
  Future<Map<String, dynamic>?> getUserStatistics() async {
    try {
      final response = await _httpClient.get('/mobile/user/statistics');
      if (response['success'] == true || response['status'] == 'success') {
        return response['data'];
      }
      return null;
    } catch (e) {
      print('Error fetching statistics: $e');
      return null;
    }
  }

  /// Get upcoming appointments
  Future<List<BookingModel>> getUpcomingAppointments() async {
    try {
      final response = await _httpClient.get('/mobile/appointments/upcoming');
      if (response['success'] == true || response['status'] == 'success') {
        final List appointments = response['data'] ?? [];
        return appointments
            .map((apt) => BookingModel.fromJson(apt))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching appointments: $e');
      return [];
    }
  }

  void dispose() {
    _httpClient.dispose();
  }
}