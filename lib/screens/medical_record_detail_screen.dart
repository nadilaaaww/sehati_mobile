import 'package:flutter/material.dart';

class MedicalRecordDetailScreen extends StatelessWidget {
  const MedicalRecordDetailScreen({super.key});

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
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 26),
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
                        'Detail Rekam Medis',
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
                    'Hasil Pemeriksaan Pasien',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Informasi diagnosis, obat, dan catatan dokter dari kunjungan terakhir.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.78),
                      fontSize: 13.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card ringkasan
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 62,
                                height: 62,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEAF2FF),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Icon(
                                  Icons.medical_information_rounded,
                                  color: primaryBlue,
                                  size: 34,
                                ),
                              ),

                              const SizedBox(width: 14),

                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kunjungan Klinik',
                                      style: TextStyle(
                                        color: primaryBlue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Pemeriksaan umum pasien',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F5E9),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Text(
                                  'Selesai',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF6F8FC),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Column(
                              children: [
                                _StaticInfoRow(
                                  icon: Icons.calendar_month_rounded,
                                  title: 'Tanggal',
                                  value: '12 Okt 2024',
                                ),
                                SizedBox(height: 12),
                                _StaticInfoRow(
                                  icon: Icons.person_rounded,
                                  title: 'Dokter',
                                  value: 'dr. Yoshinori',
                                ),
                                SizedBox(height: 12),
                                _StaticInfoRow(
                                  icon: Icons.local_hospital_rounded,
                                  title: 'Poli',
                                  value: 'Penyakit Dalam',
                                ),
                                SizedBox(height: 12),
                                _StaticInfoRow(
                                  icon: Icons.confirmation_number_rounded,
                                  title: 'No. Rekam Medis',
                                  value: 'RM-1024-001',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    _buildSectionTitle(
                      title: 'Diagnosis',
                    ),

                    const SizedBox(height: 12),

                    _buildContentCard(
                      child: const Text(
                        'Dispepsia ringan dan dehidrasi ringan akibat kurang minum air putih. Tidak ditemukan tanda bahaya lanjutan pada pemeriksaan.',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.5,
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    _buildSectionTitle(
                      title: 'Obat yang Diberikan',
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildMedicineItem(
                            name: 'Omeprazole 20mg',
                            instruction: '1x sehari sebelum makan',
                            note: 'Diminum pagi hari sebelum sarapan.',
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Divider(height: 1),
                          ),
                          _buildMedicineItem(
                            name: 'Domperidone 10mg',
                            instruction: '3x sehari jika mual',
                            note: 'Diminum hanya saat gejala mual muncul.',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    _buildSectionTitle(
                      title: 'Catatan Dokter',
                    ),

                    const SizedBox(height: 12),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF2FF),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: primaryBlue.withOpacity(0.15),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_outline_rounded,
                            color: primaryBlue,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Istirahat yang cukup, hindari makanan pedas dan asam, serta perbanyak minum air putih minimal 2 liter per hari.',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 14.5,
                                height: 1.6,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    _buildSectionTitle(
                      title: 'Ringkasan Tindakan',
                    ),

                    const SizedBox(height: 12),

                    _buildContentCard(
                      child: Column(
                        children: [
                          _buildActionItem(
                            text: 'Pemeriksaan kondisi umum pasien',
                          ),
                          const SizedBox(height: 12),
                          _buildActionItem(
                            text: 'Pemberian resep obat sesuai keluhan',
                          ),
                          const SizedBox(height: 12),
                          _buildActionItem(
                            text: 'Edukasi pola makan dan kebutuhan cairan',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Fitur download PDF akan dikembangkan.',
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.download_rounded,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Download Rekam Medis',
                          style: TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_rounded),
                        label: const Text(
                          'Kembali ke Riwayat',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primaryBlue,
                          side: const BorderSide(
                            color: primaryBlue,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle({
    required String title,
  }) {
    const Color primaryBlue = Color(0xFF2F5DAB);
    const Color orange = Color(0xFFF47B20);

    return Row(
      children: [
        Container(
          width: 5,
          height: 24,
          decoration: BoxDecoration(
            color: orange,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: primaryBlue,
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Widget _buildContentCard({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildMedicineItem({
    required String name,
    required String instruction,
    required String note,
  }) {
    const Color primaryBlue = Color(0xFF2F5DAB);
    const Color orange = Color(0xFFF47B20);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF2E8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.medication_liquid_rounded,
            color: orange,
            size: 26,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: primaryBlue,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                instruction,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 13.8,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                note,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 13,
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

  Widget _buildActionItem({
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_circle_rounded,
          color: Colors.green,
          size: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14.2,
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _StaticInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StaticInfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF2F5DAB);

    return Row(
      children: [
        Icon(
          icon,
          color: primaryBlue,
          size: 20,
        ),
        const SizedBox(width: 10),
        Text(
          '$title:',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: primaryBlue,
              fontSize: 13.5,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}