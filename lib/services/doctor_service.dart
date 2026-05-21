import 'package:sehati_mobile/core/constants.dart';
import 'http_client.dart';
import 'models.dart';

class DoctorService {
  final HttpClient _httpClient = HttpClient();

  /// 💡 PERBAIKAN FINAL: Fetch doctors dengan menggandeng Base URL live VPS
  Future<List<dynamic>> fetchDoctors({
    required String layanan,
    required String tanggal,
  }) async {
    try {
      // 💡 PERBAIKAN UTAMA: Tambahkan ${AppConstants.baseUrl} di depan rute
      final response = await _httpClient.get(
        '${AppConstants.baseUrl}/mobile/doctors?layanan=$layanan&tanggal=$tanggal',
      );

      if (response['success'] == true || response['status'] == 'success') {
        return response['data'] as List? ?? [];
      }
      return [];
    } catch (e) {
      print('Error fetching doctors: $e');
      return [];
    }
  }

  /// Get doctor by ID with detailed information
  Future<DoctorModel?> getDoctorById(int doctorId) async {
    try {
      final response = await _httpClient.get(
        '${AppConstants.doctorEndpoint}/$doctorId',
      );

      if (response['success'] == true || response['status'] == 'success') {
        return DoctorModel.fromJson(response['data']);
      }
      return null;
    } catch (e) {
      print('Error fetching doctor: $e');
      return null;
    }
  }

  /// Get available time slots for a doctor on a specific date
  Future<List<String>> getAvailableTimeSlots(int doctorId, String date) async {
    try {
      final response = await _httpClient.get(
        '${AppConstants.doctorEndpoint}/$doctorId/available-times?date=$date',
      );

      if (response['success'] == true || response['status'] == 'success') {
        final List slots = response['data'] ?? [];
        return slots.map((slot) => slot.toString()).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching time slots: $e');
      return [];
    }
  }

  /// Filter doctors by specialty
  Future<List<DoctorModel>> getDoctorsBySpecialty(String specialty) async {
    try {
      final response = await _httpClient.get(
        '${AppConstants.doctorEndpoint}?specialty=$specialty',
      );

      if (response['success'] == true || response['status'] == 'success') {
        final List doctors = response['data'] ?? [];
        return doctors
            .map((doctor) => DoctorModel.fromJson(doctor))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching doctors by specialty: $e');
      return [];
    }
  }

  /// Get doctor reviews and ratings
  Future<List<Map<String, dynamic>>> getDoctorReviews(int doctorId) async {
    try {
      final response = await _httpClient.get(
        '${AppConstants.doctorEndpoint}/$doctorId/reviews',
      );

      if (response['success'] == true || response['status'] == 'success') {
        final List reviews = response['data'] ?? [];
        return reviews.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      print('Error fetching doctor reviews: $e');
      return [];
    }
  }

  void dispose() {
    _httpClient.dispose();
  }
}