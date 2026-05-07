import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home_screen.dart';
import 'screens/face_verification_screen.dart';
import 'screens/medicine_verification_screen.dart';
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
    const Color primaryBlue = Color(0xFF2F5DAB);
    const Color orange = Color(0xFFF47B20);
    const Color backgroundColor = Color(0xFFF5F7FA);

    return MaterialApp(
      title: 'SEHATI',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: backgroundColor,

        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          primary: primaryBlue,
          secondary: orange,
          background: backgroundColor,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: primaryBlue,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: primaryBlue,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            fontFamily: 'Inter',
          ),
          iconTheme: IconThemeData(
            color: primaryBlue,
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: orange,
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              fontFamily: 'Inter',
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryBlue,
            side: const BorderSide(
              color: primaryBlue,
              width: 1.5,
            ),
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              fontFamily: 'Inter',
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF6F8FC),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: primaryBlue,
              width: 1.4,
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
          ),
        ),
      ),

      routes: {
        // Auth
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),

        // Main
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/notifications': (context) => const NotificationScreen(),

        // Verification & AI
        '/face-verification': (context) => const FaceVerificationScreen(),
        '/medicine-verification': (context) =>
            const MedicineVerificationScreen(),
        '/ai-assistant': (context) => const AiAssistantScreen(),
        '/chatbot': (context) => const ChatbotScreen(),

        // Booking Flow
        '/booking-doctor': (context) => const BookingDoctorScreen(),
        '/schedule-setting': (context) => const ScheduleSettingScreen(),
        '/booking-success': (context) => const BookingSuccessScreen(),

        // Medical data
        '/visit-history': (context) => const VisitHistoryScreen(),
        '/medical-record-detail': (context) =>
            const MedicalRecordDetailScreen(),
        '/upload-document': (context) => const UploadDocumentScreen(),

        // Profile menu
        '/personal-data': (context) => const PersonalDataScreen(),
        '/about': (context) => const AboutScreen(),
        '/faq': (context) => const FaqScreen(),
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      },
    );
  }
}