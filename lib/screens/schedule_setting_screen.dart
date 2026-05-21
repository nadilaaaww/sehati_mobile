import 'package:flutter/material.dart';
// Impor service booking hasil Fase 2
import 'package:sehati_mobile/services/booking_service.dart';

const Color darkText = Color(0xFF212121);

class ScheduleSettingScreen extends StatefulWidget {
  const ScheduleSettingScreen({super.key});

  @override
  State<ScheduleSettingScreen> createState() => _ScheduleSettingScreenState();
}

class _ScheduleSettingScreenState extends State<ScheduleSettingScreen> {
  int selectedTimeIndex = -1;
  final TextEditingController complaintController = TextEditingController();
  
  // State pengunci ganda untuk menghindari double-booking saat tombol diklik cepat
  bool _isSubmitting = false;

  final List<String> availableTimes = [
    '08.00',
    '08.30',
    '09.00',
    '09.30',
    '10.00',
    '10.30',
    '11.00',
    '11.30',
  ];

  @override
  void dispose() {
    complaintController.dispose();
    super.dispose();
  }

  // INTEGRASI API: Method Sentral Pengiriman Data Janji Temu ke Laravel VPS
  void _executeApiBooking({
    required BuildContext modalContext,
    required String doctorId,
    required DateTime selectedDate,
    required String selectedTime,
    required String complaint,
    required String name,
    required String specialty,
    required String schedule,
    required String selectedDateText,
    required String serviceType,
    required Function(bool) setModalLoading,
  }) async {
    
    // Aktifkan state loading lokal & modal
    setModalLoading(true);
    setState(() {
      _isSubmitting = true;
    });

    // Format objek DateTime menjadi string YYYY-MM-DD sesuai kontrak database backend
    String formattedDate = 
        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

    try {
      // Menembak service booking API Fase 2
      final responseData = await BookingService().createBooking(
        doctorId: int.parse(doctorId),
        selectedDate: formattedDate,
        selectedTime: selectedTime,
        notes: complaint,
        serviceType: serviceType,
      );

      // Ekstraksi nomor booking dinamis hasil generate otomatis dari database VPS
      // Menyesuaikan jika response JSON dari Laravel mengembalikan data['nomor_booking']
      String serverBookingNumber = responseData?['data']?['nomor_booking'] ?? 'BK-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

      if (mounted) {
        // Tutup modal bottom sheet terlebih dahulu
        Navigator.pop(modalContext);

        // Lompat ke halaman Sukses dengan membawa nomor antrean asli dari server!
        Navigator.pushNamed(
          context,
          '/booking-success',
          arguments: {
            'name': name,
            'specialty': specialty,
            'schedule': schedule,
            'selectedDateText': selectedDateText,
            'serviceType': serviceType,
            'selectedTime': selectedTime,
            'complaint': complaint,
            'bookingNumber': serverBookingNumber, // Data live server menggantikan BK-120225-001 statis
          },
        );
      }
    } catch (e) {
      if (mounted) {
        // Tampilkan pesan error jika koneksi RTO atau kredensial token ditolak
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membuat janji temu: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      // Matikan seluruh loading state baik di screen utama maupun modal
      setModalLoading(false);
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showBookingDetailModal({
    required String doctorId,
    required DateTime selectedDate,
    required String name,
    required String specialty,
    required String schedule,
    required String selectedDateText,
    required String serviceType,
  }) {
    const Color primaryBlue = Color(0xFF2F5DAB);
    const Color orange = Color(0xFFF47B20);

    final String selectedTime = '${availableTimes[selectedTimeIndex]} WIB';
    final String complaint = complaintController.text.trim().isEmpty
        ? 'Tidak ada catatan tambahan'
        : complaintController.text.trim();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        // Menggunakan StatefulBuilder agar perubahan loading di dalam bottom sheet ter-render instan
        return StatefulBuilder(
          builder: (BuildContext context, setStateModal) {
            return Container(
              padding: EdgeInsets.only(
                left: 22,
                right: 22,
                top: 14,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Detail Booking',
                      style: TextStyle(
                        color: primaryBlue,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Pastikan data booking sudah sesuai sebelum dikonfirmasi.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13.5,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F8FC),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 62,
                            height: 62,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF2FF),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Icon(
                              serviceType == 'Khitan'
                                  ? Icons.health_and_safety_rounded
                                  : Icons.person_rounded,
                              color: primaryBlue,
                              size: 34,
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
                                const SizedBox(height: 4),
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _buildModalInfoRow(
                      icon: Icons.medical_services_rounded,
                      title: 'Layanan',
                      value: serviceType,
                    ),
                    _buildModalInfoRow(
                      icon: Icons.calendar_month_rounded,
                      title: 'Tanggal',
                      value: selectedDateText,
                    ),
                    _buildModalInfoRow(
                      icon: Icons.access_time_rounded,
                      title: 'Waktu',
                      value: selectedTime,
                    ),
                    _buildModalInfoRow(
                      icon: Icons.schedule_rounded,
                      title: 'Jam Praktik',
                      value: schedule,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Keluhan / Catatan',
                      style: TextStyle(
                        color: primaryBlue,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F8FC),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        complaint,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13.5,
                          height: 1.45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    
                    // TOMBOL DENGAN LOADING ANIMATION
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _isSubmitting
                            ? null
                            : () {
                                _executeApiBooking(
                                  modalContext: context,
                                  doctorId: doctorId,
                                  selectedDate: selectedDate,
                                  selectedTime: selectedTime,
                                  complaint: complaint,
                                  name: name,
                                  specialty: specialty,
                                  schedule: schedule,
                                  selectedDateText: selectedDateText,
                                  serviceType: serviceType,
                                  setModalLoading: (loading) {
                                    setStateModal(() {
                                      _isSubmitting = loading;
                                    });
                                  },
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
                          disabledBackgroundColor: orange.withOpacity(0.5),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'Konfirmasi Booking',
                                style: TextStyle(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: _isSubmitting ? null : () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primaryBlue,
                          side: const BorderSide(
                            color: primaryBlue,
                            width: 1.4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: const Text(
                          'Periksa Lagi',
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF2F5DAB);
    const Color orange = Color(0xFFF47B20);
    const Color bgColor = Color(0xFFF5F7FA);

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Menangkap data esensial untuk disetor ke Laravel API kelompokmu
    final String doctorId = args?['id']?.toString() ?? '0';
    final DateTime selectedDate = args?['selectedDate'] as DateTime? ?? DateTime.now();
    
    final String name = args?['name'] ?? 'Dokter';
    final String specialty = args?['specialty'] ?? 'Layanan kesehatan';
    final String schedule = args?['schedule'] ?? '-';
    final String selectedDateText = args?['selectedDateText'] ?? '-';
    final String serviceType = args?['serviceType'] ?? 'Dokter';

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER BAR STEPS
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
                        'Pilih Waktu',
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
                    'Tentukan jam kunjungan Anda',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.4,
                      fontWeight: FontWeight.w700,
                ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tanggal dan layanan sudah dipilih. Sekarang pilih waktu kunjungan yang tersedia.',
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
                      _buildStepItem('3', 'Waktu', true),
                    ],
                  ),
                ],
              ),
            ),

            // FORM AREA & TIME GRID
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                children: [
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ringkasan Pilihan',
                          style: TextStyle(
                            color: primaryBlue,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              width: 62,
                              height: 62,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEAF2FF),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Icon(
                                serviceType == 'Khitan'
                                    ? Icons.health_and_safety_rounded
                                    : Icons.person_rounded,
                                color: primaryBlue,
                                size: 34,
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
                                  const SizedBox(height: 4),
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
                          ],
                        ),
                        const SizedBox(height: 18),
                        _buildSummaryRow(
                          icon: Icons.medical_services_rounded,
                          title: 'Layanan',
                          value: serviceType,
                        ),
                        const SizedBox(height: 12),
                        _buildSummaryRow(
                          icon: Icons.calendar_month_rounded,
                          title: 'Tanggal',
                          value: selectedDateText,
                        ),
                        const SizedBox(height: 12),
                        _buildSummaryRow(
                          icon: Icons.access_time_rounded,
                          title: 'Jam Praktik',
                          value: schedule,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Pilih Jam Kunjungan',
                    style: TextStyle(
                      color: primaryBlue,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Pilih salah satu waktu yang masih tersedia.',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13.5,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // GRID SELECTOR JAM
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: availableTimes.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 2.25,
                    ),
                    itemBuilder: (context, index) {
                      final bool isSelected = selectedTimeIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTimeIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? orange : Colors.white,
                            borderRadius: BorderRadius.circular(17),
                            border: Border.all(
                              color: isSelected ? orange : Colors.grey.shade200,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? orange.withOpacity(0.25)
                                    : Colors.black.withOpacity(0.035),
                                blurRadius: 14,
                                offset: const Offset(0, 7),
                              ),
                            ],
                          ),
                          child: Text(
                            '${availableTimes[index]} WIB',
                            style: TextStyle(
                              color: isSelected ? Colors.white : primaryBlue,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Keluhan / Catatan',
                    style: TextStyle(
                      color: primaryBlue,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Isi jika ada keluhan atau catatan yang ingin disampaikan.',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13.5,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // INPUT TEKS KELUHAN PASIEN
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.035),
                          blurRadius: 14,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: complaintController,
                      maxLines: 5,
                      style: const TextStyle(color: darkText, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Contoh: pasien merasa pusing, mual, atau ingin konsultasi lanjutan...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                          height: 1.4,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF2FF),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: primaryBlue,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Datang 10 menit lebih awal untuk konfirmasi data dan nomor antrean.',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 13.5,
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // FIXED BOTTOM NAV BUTTON AREA
            Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 18,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: selectedTimeIndex == -1 || _isSubmitting
                      ? null
                      : () {
                          _showBookingDetailModal(
                            doctorId: doctorId,
                            selectedDate: selectedDate,
                            name: name,
                            specialty: specialty,
                            schedule: schedule,
                            selectedDateText: selectedDateText,
                            serviceType: serviceType,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    disabledBackgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    selectedTimeIndex == -1
                        ? 'Pilih Waktu Terlebih Dahulu'
                        : 'Lanjutkan',
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
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

  Widget _buildSummaryRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xFF2F5DAB),
          size: 21,
        ),
        const SizedBox(width: 10),
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
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF2F5DAB),
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModalInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF2F5DAB),
            size: 21,
          ),
          const SizedBox(width: 10),
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
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF2F5DAB),
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}