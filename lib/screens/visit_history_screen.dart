import 'package:flutter/material.dart';

class VisitHistoryScreen extends StatefulWidget {
  const VisitHistoryScreen({super.key});

  @override
  State<VisitHistoryScreen> createState() => _VisitHistoryScreenState();
}

class _VisitHistoryScreenState extends State<VisitHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> histories = [
    {
      'type': 'visit',
      'date': '12 Okt 2024',
      'time': '10.00 WIB',
      'title': 'Poli Umum',
      'subtitle': 'dr. Yoshinori, Sp. PD',
      'description': 'Konsultasi Dokter',
      'status': 'Selesai',
      'queue': 'A-012',
      'isCancelled': false,
    },
    {
      'type': 'visit',
      'date': '18 Sep 2024',
      'time': '13.30 WIB',
      'title': 'Poli Anak',
      'subtitle': 'dr. Sarah Wijaya, Sp. A',
      'description': 'Konsultasi Dokter',
      'status': 'Selesai',
      'queue': 'A-009',
      'isCancelled': false,
    },
    {
      'type': 'alarm',
      'date': '12 Okt 2024',
      'time': '07.00 WIB',
      'title': 'Paracetamol 500 mg',
      'subtitle': '1 tablet setelah sarapan',
      'description': 'Verifikasi minum obat berhasil',
      'status': 'Terverifikasi',
      'queue': '-',
      'isCancelled': false,
    },
    {
      'type': 'alarm',
      'date': '12 Okt 2024',
      'time': '12.30 WIB',
      'title': 'Amoxicillin 250 mg',
      'subtitle': '1 kapsul setelah makan siang',
      'description': 'Belum melakukan verifikasi minum obat',
      'status': 'Belum Verifikasi',
      'queue': '-',
      'isCancelled': false,
    },
    {
      'type': 'visit',
      'date': '05 Sep 2024',
      'time': '09.00 WIB',
      'title': 'Layanan Khitan Anak',
      'subtitle': 'Ditangani oleh tenaga medis berpengalaman',
      'description': 'Khitan',
      'status': 'Batal',
      'queue': '-',
      'isCancelled': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> getFilteredHistories(String type) {
    if (type == 'Kunjungan') {
      return histories.where((item) => item['type'] == 'visit').toList();
    } else if (type == 'Alarm') {
      return histories.where((item) => item['type'] == 'alarm').toList();
    }

    return histories;
  }

  void _showAlarmDetail(Map<String, dynamic> item) {
    const Color primaryBlue = Color(0xFF2F5DAB);
    const Color orange = Color(0xFFF47B20);

    final bool isVerified = item['status'] == 'Terverifikasi';

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
              children: [
                Container(
                  width: 46,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF2E8),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.medication_rounded,
                    color: orange,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  item['title'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: primaryBlue,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['subtitle'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                _buildModalRow(
                  icon: Icons.calendar_month_rounded,
                  title: 'Tanggal',
                  value: item['date'],
                ),
                const SizedBox(height: 12),
                _buildModalRow(
                  icon: Icons.access_time_rounded,
                  title: 'Waktu',
                  value: item['time'],
                ),
                const SizedBox(height: 12),
                _buildModalRow(
                  icon: isVerified
                      ? Icons.check_circle_rounded
                      : Icons.info_outline_rounded,
                  title: 'Status',
                  value: item['status'],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isVerified
                        ? Colors.green.shade50
                        : const Color(0xFFFFF2E8),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    item['description'],
                    style: TextStyle(
                      color: isVerified ? Colors.green : orange,
                      fontSize: 13.5,
                      height: 1.4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
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

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF2F5DAB);
    const Color orange = Color(0xFFF47B20);
    const Color bgColor = Color(0xFFF5F7FA);

    final int totalKunjungan =
        histories.where((item) => item['type'] == 'visit').length;
    final int totalAlarm =
        histories.where((item) => item['type'] == 'alarm').length;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
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
                        'Riwayat',
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
                    'Riwayat Aktivitas Pasien',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Lihat riwayat kunjungan klinik dan riwayat alarm obat yang pernah dilakukan.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.78),
                      fontSize: 13.5,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryBox(
                          title: 'Total',
                          value: '${histories.length}',
                          icon: Icons.history_rounded,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildSummaryBox(
                          title: 'Kunjungan',
                          value: '$totalKunjungan',
                          icon: Icons.local_hospital_rounded,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildSummaryBox(
                          title: 'Alarm',
                          value: '$totalAlarm',
                          icon: Icons.alarm_rounded,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(18),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey.shade600,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
                tabs: const [
                  Tab(text: 'Semua'),
                  Tab(text: 'Kunjungan'),
                  Tab(text: 'Alarm Obat'),
                ],
              ),
            ),

            const SizedBox(height: 6),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildHistoryList(getFilteredHistories('Semua')),
                  _buildHistoryList(getFilteredHistories('Kunjungan')),
                  _buildHistoryList(getFilteredHistories('Alarm')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryBox({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 22,
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.78),
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_busy_rounded,
                color: Colors.grey.shade400,
                size: 64,
              ),
              const SizedBox(height: 14),
              const Text(
                'Belum Ada Riwayat',
                style: TextStyle(
                  color: Color(0xFF2F5DAB),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Riwayat akan muncul setelah ada kunjungan atau alarm obat yang tercatat.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      itemCount: data.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = data[index];

        if (item['type'] == 'alarm') {
          return _buildAlarmHistoryCard(item);
        }

        return _buildVisitHistoryCard(item);
      },
    );
  }

  Widget _buildVisitHistoryCard(Map<String, dynamic> item) {
    const Color primaryBlue = Color(0xFF2F5DAB);
    const Color orange = Color(0xFFF47B20);

    final bool isCancelled = item['isCancelled'];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _buildTopRow(
            icon: Icons.calendar_month_rounded,
            iconColor: primaryBlue,
            iconBg: const Color(0xFFEAF2FF),
            date: item['date'],
            time: item['time'],
            status: item['status'],
            statusColor: isCancelled ? Colors.red : Colors.green,
            statusBg: isCancelled ? Colors.red.shade50 : Colors.green.shade50,
          ),
          const SizedBox(height: 16),
          _buildMainInfoBox(
            icon: item['description'] == 'Khitan'
                ? Icons.health_and_safety_rounded
                : Icons.person_rounded,
            iconColor: primaryBlue,
            iconBg: const Color(0xFFEAF2FF),
            title: item['title'],
            subtitle: item['subtitle'],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildSmallInfo(
                  title: 'Layanan',
                  value: item['description'],
                  icon: Icons.medical_services_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSmallInfo(
                  title: 'No. Antrean',
                  value: item['queue'],
                  icon: Icons.confirmation_number_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (!isCancelled)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/medical-record-detail');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: const Text(
                  'Lihat Detail Rekam Medis',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15.5,
                  ),
                ),
              ),
            )
          else
            _buildWarningBox(
              text:
                  'Kunjungan dibatalkan, sehingga detail rekam medis tidak tersedia.',
            ),
        ],
      ),
    );
  }

  Widget _buildAlarmHistoryCard(Map<String, dynamic> item) {
    const Color orange = Color(0xFFF47B20);

    final bool isVerified = item['status'] == 'Terverifikasi';

    return GestureDetector(
      onTap: () => _showAlarmDetail(item),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: _cardDecoration(),
        child: Column(
          children: [
            _buildTopRow(
              icon: Icons.alarm_rounded,
              iconColor: orange,
              iconBg: const Color(0xFFFFF2E8),
              date: item['date'],
              time: item['time'],
              status: item['status'],
              statusColor: isVerified ? Colors.green : orange,
              statusBg:
                  isVerified ? Colors.green.shade50 : const Color(0xFFFFF2E8),
            ),
            const SizedBox(height: 16),
            _buildMainInfoBox(
              icon: Icons.medication_rounded,
              iconColor: orange,
              iconBg: const Color(0xFFFFF2E8),
              title: item['title'],
              subtitle: item['subtitle'],
            ),
            const SizedBox(height: 14),
            _buildSmallInfo(
              title: 'Keterangan',
              value: item['description'],
              icon: Icons.info_outline_rounded,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () => _showAlarmDetail(item),
                style: OutlinedButton.styleFrom(
                  foregroundColor: orange,
                  side: const BorderSide(
                    color: orange,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: const Text(
                  'Lihat Detail Alarm',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(
        color: Colors.grey.shade100,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  Widget _buildTopRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String date,
    required String time,
    required String status,
    required Color statusColor,
    required Color statusBg,
  }) {
    const Color primaryBlue = Color(0xFF2F5DAB);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: const TextStyle(
                  color: primaryBlue,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: statusBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainInfoBox({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
  }) {
    const Color primaryBlue = Color(0xFF2F5DAB);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 32,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: primaryBlue,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13.3,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallInfo({
    required String title,
    required String value,
    required IconData icon,
  }) {
    const Color primaryBlue = Color(0xFF2F5DAB);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FC),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryBlue,
            size: 19,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 11.8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: primaryBlue,
                    fontSize: 12.8,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningBox({
    required String text,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: Colors.red,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.red.shade700,
                fontSize: 13,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModalRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    const Color primaryBlue = Color(0xFF2F5DAB);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FC),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryBlue,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: primaryBlue,
              fontSize: 13.5,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}