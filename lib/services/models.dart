/// Model classes for API responses

/// Generic API Response wrapper
class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final int? statusCode;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.statusCode,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse(
      success: json['success'] ?? json['status'] == 'success',
      message: json['message'],
      data: json['data'] != null && fromJsonT != null ? fromJsonT(json['data']) : null,
      statusCode: json['status_code'],
    );
  }
}

/// Login Response
class LoginResponse {
  final String token;
  final UserModel user;

  LoginResponse({
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }
}

/// User Model
class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? dateOfBirth;
  final String? gender;
  final String? profilePicture;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.dateOfBirth,
    this.gender,
    this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      address: json['address'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      profilePicture: json['profile_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'profile_picture': profilePicture,
    };
  }
}

/// Doctor Model
class DoctorModel {
  final int id;
  final String name;
  final String specialty;
  final String? phone;
  final String? email;
  final String? bio;
  final String? profilePicture;
  final double? rating;
  final int? reviewCount;
  final bool? isAvailable;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    this.phone,
    this.email,
    this.bio,
    this.profilePicture,
    this.rating,
    this.reviewCount,
    this.isAvailable,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      specialty: json['specialty'] ?? '',
      phone: json['phone'],
      email: json['email'],
      bio: json['bio'],
      profilePicture: json['profile_picture'],
      rating: json['rating']?.toDouble(),
      reviewCount: json['review_count'],
      isAvailable: json['is_available'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'phone': phone,
      'email': email,
      'bio': bio,
      'profile_picture': profilePicture,
      'rating': rating,
      'review_count': reviewCount,
      'is_available': isAvailable,
    };
  }
}

/// Booking Model
class BookingModel {
  final int id;
  final String bookingNumber;
  final int userId;
  final int doctorId;
  final String doctorName;
  final String specialty;
  final String serviceType;
  final DateTime bookingDate;
  final String bookingTime;
  final String status;
  final String? notes;
  final DateTime createdAt;

  BookingModel({
    required this.id,
    required this.bookingNumber,
    required this.userId,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.serviceType,
    required this.bookingDate,
    required this.bookingTime,
    required this.status,
    this.notes,
    required this.createdAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? 0,
      bookingNumber: json['booking_number'] ?? '',
      userId: json['user_id'] ?? 0,
      doctorId: json['doctor_id'] ?? 0,
      doctorName: json['doctor_name'] ?? '',
      specialty: json['specialty'] ?? '',
      serviceType: json['service_type'] ?? '',
      bookingDate: json['booking_date'] != null
          ? DateTime.parse(json['booking_date'])
          : DateTime.now(),
      bookingTime: json['booking_time'] ?? '',
      status: json['status'] ?? 'pending',
      notes: json['notes'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'booking_number': bookingNumber,
      'user_id': userId,
      'doctor_id': doctorId,
      'doctor_name': doctorName,
      'specialty': specialty,
      'service_type': serviceType,
      'booking_date': bookingDate.toIso8601String(),
      'booking_time': bookingTime,
      'status': status,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Get formatted date for display
  String get formattedDate {
    return '${bookingDate.day}-${bookingDate.month}-${bookingDate.year}';
  }

  /// Check if booking is upcoming
  bool get isUpcoming {
    return bookingDate.isAfter(DateTime.now());
  }

  /// Check if booking is completed
  bool get isCompleted {
    return status.toLowerCase() == 'completed';
  }

  /// Check if booking is cancelled
  bool get isCancelled {
    return status.toLowerCase() == 'cancelled';
  }
}

/// Medicine Model
class MedicineModel {
  final int id;
  final String name;
  final String dosage;
  final String frequency;
  final DateTime startDate;
  final DateTime endDate;
  final String? notes;

  MedicineModel({
    required this.id,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.startDate,
    required this.endDate,
    this.notes,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      dosage: json['dosage'] ?? '',
      frequency: json['frequency'] ?? '',
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : DateTime.now(),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : DateTime.now(),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'notes': notes,
    };
  }

  /// Check if medicine is still active
  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }
}

/// Notification Model
class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final DateTime createdAt;
  final Map<String, dynamic>? data;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? 'info',
      isRead: json['is_read'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
      'data': data,
    };
  }
}

/// Medical Record Model
class MedicalRecordModel {
  final int id;
  final int userId;
  final int doctorId;
  final String doctorName;
  final String diagnosis;
  final String prescription;
  final String notes;
  final DateTime visitDate;
  final String? attachmentUrl;

  MedicalRecordModel({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.doctorName,
    required this.diagnosis,
    required this.prescription,
    required this.notes,
    required this.visitDate,
    this.attachmentUrl,
  });

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) {
    return MedicalRecordModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      doctorId: json['doctor_id'] ?? 0,
      doctorName: json['doctor_name'] ?? '',
      diagnosis: json['diagnosis'] ?? '',
      prescription: json['prescription'] ?? '',
      notes: json['notes'] ?? '',
      visitDate: json['visit_date'] != null
          ? DateTime.parse(json['visit_date'])
          : DateTime.now(),
      attachmentUrl: json['attachment_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'doctor_id': doctorId,
      'doctor_name': doctorName,
      'diagnosis': diagnosis,
      'prescription': prescription,
      'notes': notes,
      'visit_date': visitDate.toIso8601String(),
      'attachment_url': attachmentUrl,
    };
  }
}
