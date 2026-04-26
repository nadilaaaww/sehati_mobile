import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Pengingat Janji Temu',
      'body': 'Anda memiliki jadwal konsultasi dengan dr. Yoshinori besok pukul 10:00 AM.',
      'time': '1 jam lalu',
      'icon': Icons.calendar_today,
      'iconColor': const Color(0xFF2F5DAB),
      'read': false,
    },
    {
      'title': 'Booking Berhasil',
      'body': 'Booking dengan nomor BK-120225-001 telah berhasil dikonfirmasi.',
      'time': '3 jam lalu',
      'icon': Icons.check_circle_outline,
      'iconColor': Colors.green,
      'read': false,
    },
    {
      'title': 'Dokumen Berhasil Diupload',
      'body': 'Kartu BPJS Anda telah berhasil tersimpan di sistem kami.',
      'time': 'Kemarin',
      'icon': Icons.upload_file,
      'iconColor': const Color(0xFFF47B20),
      'read': true,
    },
    {
      'title': 'Rekam Medis Tersedia',
      'body': 'Rekam medis kunjungan Anda pada 12 Okt 2024 sudah dapat diakses.',
      'time': '3 hari lalu',
      'icon': Icons.medical_information_outlined,
      'iconColor': const Color(0xFF2F5DAB),
      'read': true,
    },
    {
      'title': 'Info Kesehatan',
      'body': 'Tips: Minum air putih minimal 8 gelas per hari untuk menjaga kesehatan tubuh Anda.',
      'time': '5 hari lalu',
      'icon': Icons.health_and_safety_outlined,
      'iconColor': Colors.teal,
      'read': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF2F5DAB)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: Color(0xFF2F5DAB),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var notif in _notifications) {
                  notif['read'] = true;
                }
              });
            },
            child: const Text(
              'Baca Semua',
              style: TextStyle(
                color: Color(0xFFF47B20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: _notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final notif = _notifications[index];
          final bool isUnread = !(notif['read'] as bool);
          return GestureDetector(
            onTap: () {
              setState(() {
                _notifications[index]['read'] = true;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isUnread ? const Color(0xFFEEF3FC) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: isUnread
                    ? Border.all(color: const Color(0xFF2F5DAB).withOpacity(0.2), width: 1)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: (notif['iconColor'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(notif['icon'] as IconData, color: notif['iconColor'] as Color, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notif['title'] as String,
                                style: TextStyle(
                                  fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                                  color: const Color(0xFF2F5DAB),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            if (isUnread)
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF47B20),
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          notif['body'] as String,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          notif['time'] as String,
                          style: const TextStyle(
                            color: Color(0xFFF47B20),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
