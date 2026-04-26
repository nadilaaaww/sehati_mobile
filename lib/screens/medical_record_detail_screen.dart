import 'package:flutter/material.dart';

class MedicalRecordDetailScreen extends StatelessWidget {
  const MedicalRecordDetailScreen({super.key});

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
          'Detail Rekam Medis',
          style: TextStyle(
            color: Color(0xFF2F5DAB),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Info
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tanggal', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        SizedBox(height: 8),
                        Text('12 Okt 2024', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2F5DAB), fontSize: 16)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Dokter', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        SizedBox(height: 8),
                        Text('dr. Yoshinori', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2F5DAB), fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Diagnosis Section
              const Text(
                'Diagnosis',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F5DAB),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: const Text(
                  'Dispepsia ringan, dehidrasi ringan akibat kurang minum air putih. Tidak ada tanda bahaya lanjutan.',
                  style: TextStyle(height: 1.5, color: Colors.black87, fontSize: 15),
                ),
              ),
              const SizedBox(height: 32),
              
              // Obat yang diberikan
              const Text(
                'Obat yang Diberikan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F5DAB),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMedicineItem('Omeprazole 20mg', '1x Sehari (Sebelum Makan)'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Divider(height: 1),
                    ),
                    _buildMedicineItem('Domperidone 10mg', '3x Sehari (Jika Mual)'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Catatan Dokter
              const Text(
                'Catatan Dokter',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F5DAB),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1FF), // Light blue box for notes
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF2F5DAB).withOpacity(0.2)),
                ),
                child: const Text(
                  'Istirahat yang cukup, hindari makanan pedas dan asam. Perbanyak minum air putih minimal 2 liter per hari.',
                  style: TextStyle(height: 1.5, color: Color(0xFF2F5DAB), fontSize: 15),
                ),
              ),
              const SizedBox(height: 48),
              
              // Download Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Logic to download
                  },
                  icon: const Icon(Icons.download, color: Colors.white),
                  label: const Text(
                    'Download PDF',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF47B20),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFFF47B20).withOpacity(0.4),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMedicineItem(String name, String instruction) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7FA),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.medication_liquid, color: Color(0xFFF47B20), size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF2F5DAB),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                instruction,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
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
