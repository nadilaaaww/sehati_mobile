import 'package:sehati_mobile/core/constants.dart';
import 'http_client.dart';
import 'models.dart';

class BookingService {
  final HttpClient _httpClient = HttpClient();

  /// Create a new booking/appointment
  Future<Map<String, dynamic>> createBooking({
    required int doctorId,
    required String selectedDate,
    required String selectedTime,
    required String serviceType,
    String? notes,
  }) async {
    try {
      final response = await _httpClient.post(
        AppConstants.bookingEndpoint,
        body: {
          'doctor_id': doctorId,
          'booking_date': selectedDate,
          'booking_time': selectedTime,
          'service_type': serviceType,
          'notes': notes ?? '',
        },
      );

      if (response['success'] == true || response['status'] == 'success') {
        return {
          'success': true,
          'message': response['message'] ?? 'Booking created successfully',
          'booking': BookingModel.fromJson(response['data'] ?? {}),
          'bookingNumber': response['data']['booking_number'] ?? '',
        };
      } else {
        return {
          'success': false,
          'message': response['message'] ?? 'Failed to create booking',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  /// Get all bookings for current user
  Future<List<BookingModel>> fetchMyBookings() async {
    try {
      final response = await _httpClient.get(
        AppConstants.bookingEndpoint,
      );

      if (response['success'] == true || response['status'] == 'success') {
        final List bookings = response['data'] ?? [];
        return bookings
            .map((booking) => BookingModel.fromJson(booking))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching bookings: $e');
      return [];
    }
  }

  /// Get upcoming bookings
  Future<List<BookingModel>> fetchUpcomingBookings() async {
    try {
      final response = await _httpClient.get(
        '${AppConstants.bookingEndpoint}?status=upcoming',
      );

      if (response['success'] == true || response['status'] == 'success') {
        final List bookings = response['data'] ?? [];
        return bookings
            .map((booking) => BookingModel.fromJson(booking))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching upcoming bookings: $e');
      return [];
    }
  }

  /// Get completed bookings (visit history)
  Future<List<BookingModel>> fetchVisitHistory() async {
    try {
      final response = await _httpClient.get(
        AppConstants.visitHistoryEndpoint,
      );

      if (response['success'] == true || response['status'] == 'success') {
        final List bookings = response['data'] ?? [];
        return bookings
            .map((booking) => BookingModel.fromJson(booking))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching visit history: $e');
      return [];
    }
  }

  /// Cancel a booking
  Future<bool> cancelBooking(int bookingId) async {
    try {
      final response = await _httpClient.put(
        '${AppConstants.bookingEndpoint}/$bookingId',
        body: {
          'status': 'cancelled',
        },
      );

      return response['success'] == true || response['status'] == 'success';
    } catch (e) {
      print('Error cancelling booking: $e');
      return false;
    }
  }

  /// Reschedule a booking
  Future<bool> rescheduleBooking(
    int bookingId,
    String newDate,
    String newTime,
  ) async {
    try {
      final response = await _httpClient.put(
        '${AppConstants.bookingEndpoint}/$bookingId',
        body: {
          'booking_date': newDate,
          'booking_time': newTime,
        },
      );

      return response['success'] == true || response['status'] == 'success';
    } catch (e) {
      print('Error rescheduling booking: $e');
      return false;
    }
  }

  void dispose() {
    _httpClient.dispose();
  }
}
