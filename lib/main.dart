import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home_screen.dart';
import 'screens/face_verification_screen.dart';
import 'screens/ai_assistant_screen.dart';
import 'screens/chatbot_screen.dart';
import 'screens/booking_doctor_screen.dart';
import 'screens/schedule_setting_screen.dart';
import 'screens/booking_success_screen.dart';
import 'screens/visit_history_screen.dart';
import 'screens/medical_record_detail_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/upload_document_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/personal_data_screen.dart';
import 'screens/about_screen.dart';
import 'screens/faq_screen.dart';

void main() {
  runApp(const SehatiApp());
}

class SehatiApp extends StatelessWidget {
  const SehatiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SEHATI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2F5DAB),
          primary: const Color(0xFF2F5DAB),
          secondary: const Color(0xFFF47B20),
        ),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const HomeScreen(),
        '/face-verification': (context) => const FaceVerificationScreen(),
        '/ai-assistant': (context) => const AiAssistantScreen(),
        '/chatbot': (context) => const ChatbotScreen(),
        '/booking-doctor': (context) => const BookingDoctorScreen(),
        '/schedule-setting': (context) => const ScheduleSettingScreen(),
        '/booking-success': (context) => const BookingSuccessScreen(),
        '/visit-history': (context) => const VisitHistoryScreen(),
        '/medical-record-detail': (context) => const MedicalRecordDetailScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/upload-document': (context) => const UploadDocumentScreen(),
        '/notifications': (context) => const NotificationScreen(),
        '/personal-data': (context) => const PersonalDataScreen(),
        '/about': (context) => const AboutScreen(),
        '/faq': (context) => const FaqScreen(),
      },
    );
  }
}
