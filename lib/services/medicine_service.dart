import 'package:sehati_mobile/core/constants.dart';
import 'http_client.dart';
import 'models.dart';

class MedicineService {
  final HttpClient _httpClient = HttpClient();

  /// Fetch all medicines for current user
  Future<List<MedicineModel>> fetchMedicines() async {
    try {
      final response = await _httpClient.get(
        AppConstants.medicineEndpoint,
      );

      if (response['success'] == true || response['status'] == 'success') {
        final List medicines = response['data'] ?? [];
        return medicines
            .map((medicine) => MedicineModel.fromJson(medicine))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching medicines: $e');
      return [];
    }
  }

  /// Get medicines by specific date
  Future<List<MedicineModel>> getMedicinesByDate(DateTime date) async {
    try {
      final formattedDate =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      
      final response = await _httpClient.get(
        '${AppConstants.medicineEndpoint}?date=$formattedDate',
      );

      if (response['success'] == true || response['status'] == 'success') {
        final List medicines = response['data'] ?? [];
        return medicines
            .map((medicine) => MedicineModel.fromJson(medicine))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching medicines by date: $e');
      return [];
    }
  }

  /// Mark medicine as taken
  Future<bool> markMedicineAsTaken(int medicineId) async {
    try {
      final response = await _httpClient.post(
        '${AppConstants.medicineEndpoint}/$medicineId/taken',
        body: {
          'taken_at': DateTime.now().toIso8601String(),
        },
      );

      return response['success'] == true || response['status'] == 'success';
    } catch (e) {
      print('Error marking medicine as taken: $e');
      return false;
    }
  }

  /// Get medicine schedule (alarm-related)
  Future<Map<String, dynamic>?> getMedicineSchedule() async {
    try {
      final response = await _httpClient.get(
        '${AppConstants.medicineEndpoint}/schedule',
      );

      if (response['success'] == true || response['status'] == 'success') {
        return response['data'];
      }
      return null;
    } catch (e) {
      print('Error fetching medicine schedule: $e');
      return null;
    }
  }

  void dispose() {
    _httpClient.dispose();
  }
}
