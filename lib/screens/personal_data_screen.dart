import 'package:flutter/material.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  bool _isEditing = false;

  final _nameController = TextEditingController(text: 'Stella Kim');
  final _nikController = TextEditingController(text: '3201234567890001');
  final _emailController = TextEditingController(text: 'stellakim@email.com');
  final _phoneController = TextEditingController(text: '+62 812 3456 7890');
  final _addressController = TextEditingController(text: 'Jl. Mawar No. 10, Jakarta Selatan');
  final _dobController = TextEditingController(text: '15 Maret 1995');

  String _selectedGender = 'Perempuan';

  @override
  void dispose() {
    _nameController.dispose();
    _nikController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    super.dispose();
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
          'Data Pribadi',
          style: TextStyle(
            color: Color(0xFF2F5DAB),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => setState(() => _isEditing = !_isEditing),
            child: Text(
              _isEditing ? 'Batal' : 'Edit',
              style: const TextStyle(
                color: Color(0xFFF47B20),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar Section
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2F5DAB),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'SK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (_isEditing)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF47B20),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              // Form Fields
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.07),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildField('Nama Lengkap', _nameController, Icons.person_outline),
                    _buildDivider(),
                    _buildField('NIK', _nikController, Icons.badge_outlined, keyboardType: TextInputType.number),
                    _buildDivider(),
                    _buildField('Email', _emailController, Icons.email_outlined, keyboardType: TextInputType.emailAddress),
                    _buildDivider(),
                    _buildField('No. Telepon', _phoneController, Icons.phone_outlined, keyboardType: TextInputType.phone),
                    _buildDivider(),
                    _buildField('Tanggal Lahir', _dobController, Icons.calendar_today_outlined),
                    _buildDivider(),
                    // Gender Dropdown
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jenis Kelamin',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.wc_outlined, size: 20, color: Colors.grey.shade500),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _isEditing
                                  ? DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _selectedGender,
                                        isDense: true,
                                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                                        items: ['Perempuan', 'Laki-laki'].map((v) {
                                          return DropdownMenuItem(value: v, child: Text(v));
                                        }).toList(),
                                        onChanged: (v) => setState(() => _selectedGender = v!),
                                      ),
                                    )
                                  : Text(
                                      _selectedGender,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    _buildDivider(),
                    _buildField('Alamat', _addressController, Icons.location_on_outlined, maxLines: 2),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              // Save Button (only when editing)
              if (_isEditing)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => _isEditing = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Data berhasil disimpan!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
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
                      'Simpan Perubahan',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Icon(icon, size: 20, color: Colors.grey.shade500),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _isEditing
                  ? TextField(
                      controller: controller,
                      keyboardType: keyboardType,
                      maxLines: maxLines,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    )
                  : Text(
                      controller.text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Divider(height: 1, color: Color(0xFFF0F0F0)),
    );
  }
}
