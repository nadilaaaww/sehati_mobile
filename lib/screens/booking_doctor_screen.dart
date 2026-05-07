import 'package:flutter/material.dart';

class BookingDoctorScreen extends StatefulWidget {
  const BookingDoctorScreen({super.key});

  @override
  State<BookingDoctorScreen> createState() => _BookingDoctorScreenState();
}

class _BookingDoctorScreenState extends State<BookingDoctorScreen> {
  bool isDokterSelected = true;
  int selectedDateIndex = 0;

  late final List<DateTime> dates;

  @override
  void initState() {
    super.initState();

    // Tanggal otomatis dari hari ini sampai 1 tahun ke depan
    dates = List.generate(
      365,
      (index) => DateTime.now().add(Duration(days: index)),
    );
  }

  String getDayName(DateTime date) {
    const days = [
      'Sen',
      'Sel',
      'Rab',
      'Kam',
      'Jum',
      'Sab',
      'Min',
    ];

    return days[date.weekday - 1];
  }

  String getMonthName(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];

    return months[date.month - 1];
  }

  String formatSelectedDate(DateTime date) {
    return '${getDayName(date)}, ${date.day} ${getMonthName(date)} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF2F5DAB);
    const Color orange = Color(0xFFF47B20);
    const Color bgColor = Color(0xFFF5F7FA);

    final DateTime selectedDate = dates[selectedDateIndex];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
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
                        'Booking Layanan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'Pilih layanan kesehatan sesuai kebutuhan Anda',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Tentukan jenis layanan, tanggal kunjungan, lalu pilih jadwal yang tersedia.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.78),
                      fontSize: 13.5,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      _buildStepItem('1', 'Layanan', true),
                      _buildStepLine(),
                      _buildStepItem('2', 'Tanggal', true),
                      _buildStepLine(),
                      _buildStepItem('3', 'Jadwal', false),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                children: [
                  // Toggle layanan
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
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
                        _buildServiceTab(
                          title: 'Dokter',
                          icon: Icons.medical_services_rounded,
                          selected: isDokterSelected,
                          onTap: () {
                            setState(() {
                              isDokterSelected = true;
                            });
                          },
                        ),
                        _buildServiceTab(
                          title: 'Khitan',
                          icon: Icons.health_and_safety_rounded,
                          selected: !isDokterSelected,
                          onTap: () {
                            setState(() {
                              isDokterSelected = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pilih Tanggal Kunjungan',
                        style: TextStyle(
                          color: primaryBlue,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        formatSelectedDate(selectedDate),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Calendar otomatis
                  SizedBox(
                    height: 98,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      itemBuilder: (context, index) {
                        final DateTime date = dates[index];
                        final bool isSelected = selectedDateIndex == index;
                        final bool isToday = index == 0;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDateIndex = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            width: 70,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? orange : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: isSelected
                                      ? orange.withOpacity(0.28)
                                      : Colors.black.withOpacity(0.04),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                              border: Border.all(
                                color: isSelected
                                    ? orange
                                    : isToday
                                        ? primaryBlue.withOpacity(0.35)
                                        : Colors.grey.shade200,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  getDayName(date),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey.shade500,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                const SizedBox(height: 7),

                                Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : primaryBlue,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  getMonthName(date),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white.withOpacity(0.9)
                                        : Colors.grey.shade500,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                if (isToday) ...[
                                  const SizedBox(height: 4),
                                  Container(
                                    width: 28,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.white
                                          : primaryBlue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Ringkasan tanggal terpilih
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF2FF),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_rounded,
                          color: primaryBlue,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Tanggal dipilih: ${formatSelectedDate(selectedDate)}',
                            style: const TextStyle(
                              color: primaryBlue,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isDokterSelected
                            ? 'Dokter Tersedia'
                            : 'Layanan Khitan Tersedia',
                        style: const TextStyle(
                          color: primaryBlue,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF2FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isDokterSelected ? '2 dokter' : '1 layanan',
                          style: const TextStyle(
                            color: primaryBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  if (isDokterSelected) ...[
                    _buildDoctorCard(
                      context,
                      name: 'dr. Yoshinori, Sp. PD',
                      specialty: 'Spesialis Penyakit Dalam',
                      schedule: '08.00 - 12.00 WIB',
                      rating: '4.8',
                      queue: 'Estimasi antrean 5 pasien',
                      icon: Icons.person_rounded,
                      selectedDate: selectedDate,
                    ),
                    const SizedBox(height: 16),
                    _buildDoctorCard(
                      context,
                      name: 'dr. Sarah Wijaya, Sp. A',
                      specialty: 'Spesialis Anak',
                      schedule: '13.00 - 16.00 WIB',
                      rating: '4.9',
                      queue: 'Estimasi antrean 3 pasien',
                      icon: Icons.person_2_rounded,
                      selectedDate: selectedDate,
                    ),
                  ] else ...[
                    _buildDoctorCard(
                      context,
                      name: 'Layanan Khitan Anak',
                      specialty: 'Ditangani oleh tenaga medis berpengalaman',
                      schedule: '09.00 - 14.00 WIB',
                      rating: '4.7',
                      queue: 'Estimasi antrean 2 pasien',
                      icon: Icons.health_and_safety_rounded,
                      selectedDate: selectedDate,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem(String number, String label, bool active) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.white.withOpacity(0.25),
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: TextStyle(
              color: active ? const Color(0xFF2F5DAB) : Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(active ? 0.95 : 0.65),
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine() {
    return Expanded(
      child: Container(
        height: 1.5,
        margin: const EdgeInsets.only(bottom: 22, left: 8, right: 8),
        color: Colors.white.withOpacity(0.35),
      ),
    );
  }

  Widget _buildServiceTab({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          height: 50,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF2F5DAB) : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selected ? Colors.white : Colors.grey.shade500,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.grey.shade600,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorCard(
    BuildContext context, {
    required String name,
    required String specialty,
    required String schedule,
    required String rating,
    required String queue,
    required IconData icon,
    required DateTime selectedDate,
  }) {
    const Color primaryBlue = Color(0xFF2F5DAB);
    const Color orange = Color(0xFFF47B20);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.055),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade100,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  icon,
                  color: primaryBlue,
                  size: 36,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: primaryBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      specialty,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF2E8),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: orange,
                      size: 16,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      rating,
                      style: const TextStyle(
                        color: orange,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F8FC),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                _buildInfoRow(
                  icon: Icons.access_time_rounded,
                  title: 'Jam Praktik',
                  value: schedule,
                ),
                const SizedBox(height: 10),
                _buildInfoRow(
                  icon: Icons.groups_rounded,
                  title: 'Antrean',
                  value: queue,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/schedule-setting',
                  arguments: {
                    'name': name,
                    'specialty': specialty,
                    'schedule': schedule,
                    'selectedDate': selectedDate,
                    'selectedDateText': formatSelectedDate(selectedDate),
                    'serviceType': isDokterSelected ? 'Dokter' : 'Khitan',
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pilih Jadwal',
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 21,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF2F5DAB),
          size: 20,
        ),
        const SizedBox(width: 10),
        Text(
          '$title: ',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF2F5DAB),
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}