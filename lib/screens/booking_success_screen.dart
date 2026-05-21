import 'package:flutter/material.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF2F5DAB);
    const Color orange = Color(0xFFF47B20);

    // MENANGKAP PAYLOAD LIVE DARI DATABASE VPS HASIL EKSEKUSI FASE 3
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String bookingNumber = args?['bookingNumber'] ?? 'BK-RESERVED';
    final String name = args?['name'] ?? 'Tenaga Medis';
    final String specialty = args?['specialty'] ?? 'Layanan Kesehatan';
    final String selectedDateText = args?['selectedDateText'] ?? '-';
    final String selectedTime = args?['selectedTime'] ?? '-';
    final String serviceType = args?['serviceType'] ?? 'Dokter';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // ANIMASI/IKON BERHASIL
                      Container(
                        width: 118,
                        height: 118,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.18),
                              blurRadius: 24,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.green,
                          size: 82,
                        ),
                      ),

                      const SizedBox(height: 32),

                      const Text(
                        'Booking Berhasil!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryBlue,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Janji temu Anda sudah berhasil dibuat. Silakan datang sesuai jadwal yang dipilih.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // NOTA TIKET ELEKTRONIK DINAMIS
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
                            const Text(
                              'Nomor Booking',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              bookingNumber, // Menampilkan nomor antrean asli hasil generate sistem Laravel VPS
                              style: const TextStyle(
                                color: primaryBlue,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2,
                              ),
                            ),

                            const Divider(height: 30),

                            _buildDetailRow('Layanan', serviceType),
                            const SizedBox(height: 10),
                            _buildDetailRow('Pilihan', name),
                            const SizedBox(height: 10),
                            _buildDetailRow('Keterangan', specialty),
                            const SizedBox(height: 10),
                            _buildDetailRow('Tanggal', selectedDateText),
                            const SizedBox(height: 10),
                            _buildDetailRow('Waktu', selectedTime),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),

              // PENGAMAN ALUR NAVIGASI AGAR TIDAK BISA DI-BACK MANUAL OLEH USER
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/visit-history');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Lihat Detail Kunjungan',
                    style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  },
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
                  child: const Text(
                    'Kembali ke Beranda',
                    style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildDetailRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        const SizedBox(width: 12),
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
}