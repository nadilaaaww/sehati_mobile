import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF2F5DAB);
    const Color orange = Color(0xFFF47B20);
    const Color bgColor = Color(0xFFF5F7FA);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              decoration: const BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 19,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Tentang SEHATI',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'Aplikasi kesehatan digital untuk membantu pasien lebih mudah mengakses layanan klinik.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.5,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.16),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Versi 1.0.0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
                child: Column(
                  children: [
                    // Logo Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              color: orange,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: orange.withOpacity(0.28),
                                  blurRadius: 22,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.health_and_safety_rounded,
                              color: Colors.white,
                              size: 52,
                            ),
                          ),

                          const SizedBox(height: 18),

                          const Text(
                            'SEHATI',
                            style: TextStyle(
                              color: primaryBlue,
                              fontSize: 31,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Sistem pelayanan kesehatan yang praktis, cepat, dan terintegrasi dalam satu aplikasi.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14.5,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Tentang Kami
                    _buildSectionCard(
                      title: 'Tentang Aplikasi',
                      icon: Icons.info_outline_rounded,
                      child: Text(
                        'SEHATI adalah aplikasi kesehatan digital yang dirancang untuk memudahkan pasien dalam mengakses layanan klinik. Melalui aplikasi ini, pengguna dapat melakukan booking kunjungan, melihat riwayat rekam medis, mengelola jadwal obat, menggunakan asisten AI, serta menyimpan dokumen kesehatan secara lebih praktis.',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14.5,
                          height: 1.65,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Fitur Utama
                    _buildSectionCard(
                      title: 'Fitur Utama',
                      icon: Icons.apps_rounded,
                      child: Column(
                        children: [
                          _buildFeatureItem(
                            icon: Icons.event_available_rounded,
                            title: 'Booking Kunjungan',
                            description:
                                'Memilih dokter, tanggal, dan waktu kunjungan secara mudah.',
                          ),
                          const SizedBox(height: 14),
                          _buildFeatureItem(
                            icon: Icons.medical_information_rounded,
                            title: 'Rekam Medis',
                            description:
                                'Melihat detail riwayat pemeriksaan dan obat yang diberikan.',
                          ),
                          const SizedBox(height: 14),
                          _buildFeatureItem(
                            icon: Icons.alarm_rounded,
                            title: 'Alarm Obat',
                            description:
                                'Membantu pasien mengingat jadwal konsumsi obat.',
                          ),
                          const SizedBox(height: 14),
                          _buildFeatureItem(
                            icon: Icons.smart_toy_rounded,
                            title: 'Asisten AI',
                            description:
                                'Membantu pengguna mendapatkan informasi awal terkait keluhan ringan.',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Informasi
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            icon: Icons.business_outlined,
                            label: 'Pengembang',
                            value: 'Tim SEHATI Indonesia',
                          ),
                          const Divider(height: 1, indent: 22, endIndent: 22),
                          _buildInfoRow(
                            icon: Icons.language_outlined,
                            label: 'Website',
                            value: 'www.sehati.id',
                          ),
                          const Divider(height: 1, indent: 22, endIndent: 22),
                          _buildInfoRow(
                            icon: Icons.email_outlined,
                            label: 'Email',
                            value: 'support@sehati.id',
                          ),
                          const Divider(height: 1, indent: 22, endIndent: 22),
                          _buildInfoRow(
                            icon: Icons.phone_outlined,
                            label: 'Hotline',
                            value: '1500-123',
                          ),
                          const Divider(height: 1, indent: 22, endIndent: 22),
                          _buildInfoRow(
                            icon: Icons.update_outlined,
                            label: 'Terakhir Diperbarui',
                            value: 'April 2025',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    Text(
                      '© 2025 SEHATI. Hak Cipta Dilindungi.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    const Color primaryBlue = Color(0xFF2F5DAB);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2FF),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: primaryBlue,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: primaryBlue,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    const Color primaryBlue = Color(0xFF2F5DAB);
    const Color orange = Color(0xFFF47B20);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF2E8),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: orange,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: primaryBlue,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13.3,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    const Color primaryBlue = Color(0xFF2F5DAB);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: primaryBlue,
              size: 21,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: primaryBlue,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}