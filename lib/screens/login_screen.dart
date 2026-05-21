import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sehati_mobile/services/auth_service.dart'; 
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 1. KONTROLER INPUT & STATE UTAMA
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isLoading = false; // Mengontrol interaktivitas tombol saat proses API berlangsung

  static const Color primaryBlue = Color(0xFF2F5DAB);
  static const Color darkBlue = Color(0xFF244E97);
  static const Color orange = Color(0xFFF47B20);
  static const Color softBlue = Color(0xFFEAF1FF);
  static const Color lightBlue = Color(0xFFF6F9FF);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color darkText = Color(0xFF1F2937);
  static const Color borderColor = Color(0xFFE3E9F2);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 2. FUNGSI EKSEKUSI API LOGIN (MODE INTEGRASI FASE 3)
  void _handleLogin() async {
    // Validasi Form Client-Side sebelum menembak VPS
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Memanggil Driver Autentikasi Fase 2 menggunakan input Email
      final result = await AuthService().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (result['success'] == true) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Berhasil! Selamat datang di SEHATI.'),
              backgroundColor: Colors.green,
            ),
          );
          // Masuk ke halaman Beranda jika kredensial benar
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        // Jika server menolak (karena email/password asal-asalan)
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'Email atau password salah.'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal terhubung ke server: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER AREA
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 14, 24, 22),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryBlue,
                    darkBlue,
                  ],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 26,
                    left: 8,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.07),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 46,
                    right: 12,
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 260,
                        height: 200,
                        child: Transform.translate(
                          offset: const Offset(18, 18),
                          child: Lottie.asset(
                            'assets/Doctor.json',
                            fit: BoxFit.contain,
                            repeat: true,
                            animate: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 0),
                      const Text(
                        'SEHATI',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 2.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Masuk untuk mengakses layanan kesehatan Anda',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.10),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.health_and_safety_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Cepat • Aman • Praktis',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // FORM AREA (SUDAH DI-WRAP DENGAN FORM VALIDATOR & SINGLECHILDSCROLLVIEW)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 18),
                  child: Form(
                    key: _formKey,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Selamat Datang Kembali',
                                    style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w900,
                                      color: darkText,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    'Silakan masuk menggunakan Email dan password yang sudah terdaftar.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: textGrey,
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  
                                  // INPUT EMAIL
                                  _buildLabel('Email'),
                                  const SizedBox(height: 8),
                                  _buildTextField(
                                    hintText: 'Masukkan Email Anda',
                                    icon: Icons.email_outlined,
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return 'Email tidak boleh kosong';
                                      }
                                      // Validasi format email regex standar industri
                                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                      if (!emailRegex.hasMatch(value.trim())) {
                                        return 'Masukkan format email yang valid';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 18),

                                  // INPUT PASSWORD
                                  _buildLabel('Password'),
                                  const SizedBox(height: 8),
                                  _buildPasswordField(),
                                  const SizedBox(height: 10),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/forgot-password');
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: const Text(
                                        'Lupa Password?',
                                        style: TextStyle(
                                          color: primaryBlue,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 22),

                                  // TOMBOL MASUK DENGAN INTERAKSI LOADING STATE
                                  SizedBox(
                                    width: double.infinity,
                                    height: 58,
                                    child: ElevatedButton(
                                      onPressed: _isLoading ? null : _handleLogin,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryBlue,
                                        foregroundColor: Colors.white,
                                        disabledBackgroundColor: primaryBlue.withOpacity(0.6),
                                        elevation: 0,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18),
                                        ),
                                      ),
                                      child: _isLoading
                                          ? const SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2.5,
                                              ),
                                            )
                                          : const Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Masuk',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w800,
                                                    letterSpacing: 0.2,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Icon(
                                                  Icons.arrow_forward_rounded,
                                                  size: 22,
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 18),

                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: softBlue,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: const Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.verified_user_rounded,
                                          color: primaryBlue,
                                          size: 22,
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            'Data akun dan riwayat kesehatan Anda tersimpan dengan aman.',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: primaryBlue,
                                              height: 1.4,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  // PENGAMAN OVERFLOW: Mengubah Spacer lama menjadi Jarak Tetap sesuai instruksi fixes kamu
                                  const SizedBox(height: 28),
                                  
                                  Center(
                                    child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: textGrey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: [
                                          const TextSpan(text: 'Belum punya akun? '),
                                          WidgetSpan(
                                            alignment: PlaceholderAlignment.middle,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const RegisterScreen(),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'Daftar',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: orange,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Center(
                                    child: Text(
                                      'Klinik Sehati Jember',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF9CA3AF),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        color: darkText,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        style: const TextStyle(color: darkText, fontSize: 15),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(
            icon,
            color: primaryBlue,
            size: 22,
          ),
          border: InputBorder.none,
          errorStyle: const TextStyle(height: 0.8, color: Colors.redAccent),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        style: const TextStyle(color: darkText, fontSize: 15),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password tidak boleh kosong';
          }
          if (value.length < 6) {
            return 'Password minimal terdiri dari 6 karakter';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Masukkan password',
          hintStyle: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: const Icon(
            Icons.lock_outline_rounded,
            color: primaryBlue,
            size: 22,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              color: textGrey,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          border: InputBorder.none,
          errorStyle: const TextStyle(height: 0.8, color: Colors.redAccent),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}