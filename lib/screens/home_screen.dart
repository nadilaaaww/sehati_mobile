import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static const Color primaryBlue = Color(0xFF2F5DAB);
  static const Color orange = Color(0xFFF47B20);
  static const Color softBg = Color(0xFFF5F7FA);
  static const Color softBlue = Color(0xFFEAF1FF);
  static const Color softOrange = Color(0xFFFFF3E8);
  static const Color darkText = Color(0xFF1F2937);
  static const Color greyText = Color(0xFF6B7280);
  static const Color green = Color(0xFF2E7D32);
  static const Color chatGreen = Color(0xFF20D34A);

  void _showQueueDetail({
    required String queueNumber,
    required String status,
    required String poli,
    required String doctor,
    required String time,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(32),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: 78,
                height: 78,
                decoration: BoxDecoration(
                  color: softOrange,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.confirmation_number_rounded,
                  color: orange,
                  size: 42,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Nomor Antrian Anda',
                style: TextStyle(
                  fontSize: 16,
                  color: greyText,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                queueNumber,
                style: const TextStyle(
                  fontSize: 46,
                  color: primaryBlue,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7EE),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: green,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildQueueInfoRow(
                icon: Icons.local_hospital_rounded,
                title: 'Poli Tujuan',
                value: poli,
              ),
              const SizedBox(height: 14),
              _buildQueueInfoRow(
                icon: Icons.person_rounded,
                title: 'Dokter',
                value: doctor,
              ),
              const SizedBox(height: 14),
              _buildQueueInfoRow(
                icon: Icons.access_time_rounded,
                title: 'Waktu Kunjungan',
                value: time,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Mengerti',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMedicineDetail({
    required String time,
    required String medicineName,
    required String dose,
    required String instruction,
    required String description,
    required String status,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(32),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Container(
                      width: 66,
                      height: 66,
                      decoration: BoxDecoration(
                        color: softOrange,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Icon(
                        Icons.medication_rounded,
                        color: orange,
                        size: 36,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medicineName,
                            style: const TextStyle(
                              color: darkText,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            dose,
                            style: const TextStyle(
                              color: greyText,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: softBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _buildMedicineInfoRow(
                        icon: Icons.access_time_rounded,
                        title: 'Jam Minum',
                        value: '$time WIB',
                      ),
                      const SizedBox(height: 14),
                      _buildMedicineInfoRow(
                        icon: Icons.restaurant_rounded,
                        title: 'Aturan Minum',
                        value: instruction,
                      ),
                      const SizedBox(height: 14),
                      _buildMedicineInfoRow(
                        icon: Icons.verified_rounded,
                        title: 'Status',
                        value: status,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Keterangan Obat',
                  style: TextStyle(
                    color: darkText,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    color: greyText,
                    fontSize: 13,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/medicine-verification');
                    },
                    icon: const Icon(Icons.face_retouching_natural_rounded),
                    label: const Text(
                      'Verifikasi Minum Obat',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'AI akan membantu memeriksa wajah pasien, tangan, obat, dan aktivitas minum obat.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: greyText.withOpacity(0.9),
                      fontSize: 12,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQueueInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: softBg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: primaryBlue,
              size: 22,
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
                    color: greyText,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    color: darkText,
                    fontSize: 15,
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

  Widget _buildMedicineInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: primaryBlue,
            size: 20,
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
                  color: greyText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  color: darkText,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/profile');
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: softBlue,
          borderRadius: BorderRadius.circular(17),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Icon(
          Icons.person_rounded,
          color: primaryBlue,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/notifications');
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Icon(
          Icons.notifications_rounded,
          color: primaryBlue,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildVisitCard({
    required String dateLabel,
    required String poli,
    required String doctor,
    required String time,
    required String queueNumber,
    required String status,
    required bool isToday,
  }) {
    return GestureDetector(
      onTap: () {
        _showQueueDetail(
          queueNumber: queueNumber,
          status: status,
          poli: poli,
          doctor: doctor,
          time: '$dateLabel, $time WIB',
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: isToday
                ? orange.withOpacity(0.18)
                : const Color(0xFFE5E7EB),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: isToday ? softOrange : softBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                isToday
                    ? Icons.confirmation_number_rounded
                    : Icons.event_note_rounded,
                color: isToday ? orange : primaryBlue,
                size: 34,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    poli,
                    style: const TextStyle(
                      fontSize: 17,
                      color: darkText,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    doctor,
                    style: const TextStyle(
                      fontSize: 13,
                      color: greyText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 14,
                        color: isToday ? orange : primaryBlue,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          '$dateLabel • $time WIB',
                          style: TextStyle(
                            color: isToday ? primaryBlue : greyText,
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right_rounded,
              color: greyText,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/booking-doctor');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/visit-history');
    } else if (index == 3) {
      Navigator.pushNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softBg,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header pasien
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat datang,',
                          style: TextStyle(
                            fontSize: 15,
                            color: greyText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Stella Kim',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: primaryBlue,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Semoga sehat selalu hari ini',
                          style: TextStyle(
                            fontSize: 13,
                            color: greyText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      _buildNotificationButton(),
                      const SizedBox(width: 10),
                      _buildProfileButton(),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 26),

              // Banner utama
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryBlue,
                      Color(0xFF4F7ED9),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: primaryBlue.withOpacity(0.22),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              'Pasien Aktif',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Pantau jadwal kunjungan dan obat dari Klinik Sehati.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Row(
                            children: [
                              Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Hari ini, 12 Okt 2026',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Container(
                      width: 78,
                      height: 78,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: const Icon(
                        Icons.health_and_safety_rounded,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              // Menu ringkas
              Row(
                children: [
                  Expanded(
                    child: _buildMiniCard(
                      title: 'Kunjungan',
                      value: '2 Jadwal',
                      icon: Icons.local_hospital_rounded,
                      color: primaryBlue,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildMiniCard(
                      title: 'Obat',
                      value: '3 Jadwal',
                      icon: Icons.medication_rounded,
                      color: orange,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              const Text(
                'Jadwal Kunjungan',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  color: darkText,
                ),
              ),

              const SizedBox(height: 14),

              _buildVisitCard(
                dateLabel: 'Hari ini, 12 Okt 2026',
                poli: 'Poli Umum',
                doctor: 'dr. Yoshinori, Sp. PD',
                time: '10:00',
                queueNumber: 'A-024',
                status: 'Status: Menunggu Panggilan',
                isToday: true,
              ),

              const SizedBox(height: 12),

              _buildVisitCard(
                dateLabel: 'Rabu, 14 Okt 2026',
                poli: 'Poli Gizi',
                doctor: 'dr. Aisyah Putri',
                time: '09:30',
                queueNumber: '-',
                status: 'Status: Terjadwal',
                isToday: false,
              ),

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Jadwal Obat Hari Ini',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: darkText,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: softOrange,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'Dari Klinik',
                      style: TextStyle(
                        color: orange,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              _buildAlarmCard(
                time: '07:00',
                medicineName: 'Paracetamol 500 mg',
                instruction: 'Setelah sarapan',
                status: 'Belum diverifikasi',
                icon: Icons.medication_rounded,
                onTap: () {
                  _showMedicineDetail(
                    time: '07:00',
                    medicineName: 'Paracetamol 500 mg',
                    dose: '1 tablet',
                    instruction: 'Diminum setelah sarapan',
                    status: 'Belum diverifikasi',
                    description:
                        'Obat ini digunakan untuk membantu meredakan demam atau nyeri ringan. Pastikan obat diminum sesuai jadwal yang diberikan oleh Klinik Sehati.',
                  );
                },
              ),

              const SizedBox(height: 12),

              _buildAlarmCard(
                time: '12:30',
                medicineName: 'Amoxicillin 250 mg',
                instruction: 'Setelah makan siang',
                status: 'Belum diverifikasi',
                icon: Icons.medication_liquid_rounded,
                onTap: () {
                  _showMedicineDetail(
                    time: '12:30',
                    medicineName: 'Amoxicillin 250 mg',
                    dose: '1 kapsul',
                    instruction: 'Diminum setelah makan siang',
                    status: 'Belum diverifikasi',
                    description:
                        'Obat ini diberikan sesuai anjuran dokter. Minum obat secara teratur dan jangan menghentikan penggunaan tanpa arahan dari tenaga kesehatan.',
                  );
                },
              ),

              const SizedBox(height: 12),

              _buildAlarmCard(
                time: '19:00',
                medicineName: 'Vitamin B Complex',
                instruction: 'Setelah makan malam',
                status: 'Menunggu jadwal',
                icon: Icons.local_pharmacy_rounded,
                onTap: () {
                  _showMedicineDetail(
                    time: '19:00',
                    medicineName: 'Vitamin B Complex',
                    dose: '1 tablet',
                    instruction: 'Diminum setelah makan malam',
                    status: 'Menunggu jadwal',
                    description:
                        'Vitamin ini digunakan untuk membantu menjaga daya tahan tubuh dan mendukung proses pemulihan pasien.',
                  );
                },
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      // Chatbot floating button
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: chatGreen,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: chatGreen.withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/chatbot');
          },
          icon: const Icon(
            Icons.chat_bubble_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 18,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onBottomNavTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: primaryBlue,
          unselectedItemColor: Colors.grey[400],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, size: 26),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded, size: 26),
              label: 'Booking',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_rounded, size: 26),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded, size: 26),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.045),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: color,
              size: 25,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: darkText,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  title,
                  style: const TextStyle(
                    color: greyText,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlarmCard({
    required String time,
    required String medicineName,
    required String instruction,
    required String status,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final bool isWaiting = status.toLowerCase().contains('menunggu');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isWaiting
                ? const Color(0xFFE5E7EB)
                : orange.withOpacity(0.20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 14,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isWaiting ? const Color(0xFFF3F4F6) : softOrange,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                icon,
                color: isWaiting ? greyText : orange,
                size: 29,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$time WIB',
                    style: TextStyle(
                      color: isWaiting ? greyText : primaryBlue,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    medicineName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: darkText,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    instruction,
                    style: const TextStyle(
                      color: greyText,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: isWaiting
                          ? const Color(0xFFF3F4F6)
                          : const Color(0xFFFFF3E8),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: isWaiting ? greyText : orange,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: softBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.keyboard_arrow_right_rounded,
                color: greyText,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}