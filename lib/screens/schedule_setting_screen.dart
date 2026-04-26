import 'package:flutter/material.dart';

class ScheduleSettingScreen extends StatefulWidget {
  const ScheduleSettingScreen({super.key});

  @override
  State<ScheduleSettingScreen> createState() => _ScheduleSettingScreenState();
}

class _ScheduleSettingScreenState extends State<ScheduleSettingScreen> {
  String _selectedDate = '';
  String _selectedTime = '';

  Future<void> _showDateTimePicker(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Pilih Tanggal & Waktu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F5DAB),
                  ),
                ),
                const SizedBox(height: 24),
                // Pseudo-calendar header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, color: Color(0xFF2F5DAB)),
                      onPressed: () {},
                    ),
                    const Text(
                      'Februari 2025',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, color: Color(0xFF2F5DAB)),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Days header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                      .map((day) => Text(
                            day,
                            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 12),
                // Calendar grid mockup
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1,
                  ),
                  itemCount: 31,
                  itemBuilder: (context, index) {
                    bool isSelected = index == 11; // Example: 12th is selected
                    return Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2F5DAB) : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                // Time slots
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildTimeSlot('09:00 AM', false),
                    _buildTimeSlot('10:00 AM', true),
                    _buildTimeSlot('11:00 AM', false),
                    _buildTimeSlot('01:00 PM', false),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedDate = '12 Feb 2025';
                        _selectedTime = '10:00 AM';
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF47B20),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text('Konfirmasi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimeSlot(String time, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF47B20) : Colors.white,
        border: Border.all(color: isSelected ? const Color(0xFFF47B20) : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        time,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade700,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Future<void> _showBookingDetailModal(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Detail Booking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F5DAB),
                ),
              ),
              const SizedBox(height: 24),
              // Doctor Info
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: NetworkImage('https://i.pravatar.cc/150?img=11'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'dr. Yoshinori, Sp. PD',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F5DAB),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Spesialis Penyakit Dalam',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 32),
              // Date & Time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tanggal', style: TextStyle(color: Colors.grey)),
                  Text(
                    _selectedDate.isEmpty ? '12 Feb 2025' : _selectedDate,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2F5DAB)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Waktu', style: TextStyle(color: Colors.grey)),
                  Text(
                    _selectedTime.isEmpty ? '10:00 AM' : _selectedTime,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2F5DAB)),
                  ),
                ],
              ),
              const Divider(height: 32),
              // Keluhan
              const Text('Ringkasan Keluhan', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              const Text(
                'Sering merasa mual dan pusing sejak dua hari yang lalu.',
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
              ),
              const SizedBox(height: 40),
              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // close modal
                    Navigator.pushNamed(context, '/booking-success');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF47B20),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Konfirmasi Booking',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

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
          'Atur Jadwal',
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
              // Dropdown
              const Text('Pilih Dokter / Spesialis', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2F5DAB))),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: 'dr. Yoshinori, Sp. PD',
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                    items: ['dr. Yoshinori, Sp. PD', 'dr. Sarah Wijaya, Sp. A'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Date & Time Picker
              const Text('Pilih Tanggal & Waktu', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2F5DAB))),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => _showDateTimePicker(context),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month, color: Color(0xFFF47B20)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _selectedDate.isEmpty ? 'Pilih Jadwal' : '$_selectedDate - $_selectedTime',
                          style: TextStyle(
                            color: _selectedDate.isEmpty ? Colors.grey : Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Textarea Keluhan
              const Text('Keluhan / Catatan', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2F5DAB))),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Tuliskan keluhan atau gejala yang Anda rasakan...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => _showBookingDetailModal(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F5DAB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFF2F5DAB).withOpacity(0.4),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
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
}
