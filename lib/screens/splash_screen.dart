import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const Color primaryBlue = Color(0xFF2F5DAB);
  static const Color orange = Color(0xFFF47B20);
  static const Color softBlue = Color(0xFFEAF1FF);
  static const Color softOrange = Color(0xFFFFF1E7);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color darkText = Color(0xFF1F2937);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Blur setengah lingkaran kiri atas
          Positioned(
            top: -120,
            left: -90,
            child: _BlurCircle(
              size: 190,
              color: primaryBlue.withOpacity(0.22),
            ),
          ),

          // Blur setengah lingkaran kanan atas
          Positioned(
            top: -120,
            right: -80,
            child: _BlurCircle(
              size: 180,
              color: primaryBlue.withOpacity(0.18),
            ),
          ),

          // Tambahan blur kecil orange agar tampilan lebih hidup
          Positioned(
            top: 95,
            right: 30,
            child: _BlurCircle(
              size: 55,
              color: orange.withOpacity(0.18),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  const Spacer(),

                  // Animasi utama
                  SizedBox(
                    width: 360,
                    height: 300,
                    child: Lottie.asset(
                      'assets/hospital_preloaded.json',
                      fit: BoxFit.contain,
                      repeat: true,
                      animate: true,
                    ),
                  ),

                  const SizedBox(height: 2),

                  // Nama aplikasi
                  const Text(
                    'SEHATI',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: primaryBlue,
                      letterSpacing: 3,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Tagline
                  const Text(
                    'Sahabat Digital untuk\nKesehatan Anda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: textGrey,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Badge kecil
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: softBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          size: 17,
                          color: primaryBlue,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Layanan Klinik Lebih Mudah',
                          style: TextStyle(
                            fontSize: 13,
                            color: primaryBlue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Card informasi utama
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.92),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFE5EAF3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.045),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: const [
                        _FeatureItem(
                          icon: Icons.calendar_month_rounded,
                          title: 'Riwayat Kunjungan',
                          description:
                              'Lihat kembali data kunjungan klinik dengan praktis.',
                          backgroundColor: softBlue,
                          iconColor: primaryBlue,
                        ),
                        SizedBox(height: 14),
                        _FeatureItem(
                          icon: Icons.medical_information_rounded,
                          title: 'Informasi Kesehatan',
                          description:
                              'Dapatkan informasi layanan dan kesehatan secara mudah.',
                          backgroundColor: softOrange,
                          iconColor: orange,
                        ),
                        SizedBox(height: 14),
                        _FeatureItem(
                          icon: Icons.alarm_rounded,
                          title: 'Alarm Obat',
                          description:
                              'Bantu pasien mengingat jadwal minum obat dengan lebih teratur.',
                          backgroundColor: softBlue,
                          iconColor: primaryBlue,
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Tombol mulai
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Mulai Sekarang',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Footer
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_hospital_rounded,
                        size: 16,
                        color: orange,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Klinik Sehati Jember',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF9CA3AF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget blur lingkaran
class _BlurCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _BlurCircle({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: 35,
        sigmaY: 35,
      ),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color backgroundColor;
  final Color iconColor;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 25,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14.5,
                  color: Color(0xFF1F2937),
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12.8,
                  color: Color(0xFF6B7280),
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}