import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/address.dart';
import 'package:flutter_shopping_app/view_models/auth_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _streetController = TextEditingController();
  final _districtController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();

  final List<String> _roles = ['Customer', 'Seller'];
  String _selectedRole = 'Customer';
  bool _obscurePassword = true;
  bool _isLoading = false;

  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/video/shopping.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() => _isVideoInitialized = true);
          _videoController.setLooping(true);
          _videoController.play();
        }
      });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _streetController.dispose();
    _districtController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_isVideoInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController.value.size.width,
                  height: _videoController.value.size.height,
                  child: VideoPlayer(_videoController),
                ),
              ),
            )
          else
            Container(color: Colors.black),

          Container(color: Colors.black.withValues(alpha: 0.4)),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.72),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      const Icon(Icons.shopping_bag_rounded, color: Colors.blue, size: 48),
                      const SizedBox(height: 12),
                      const Text(
                        'Tạo tài khoản',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Chào mừng bạn đến với FuFu \u2764',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Thông tin cơ bản
                      _sectionLabel('Thông tin tài khoản'),
                      const SizedBox(height: 10),
                      _AuthField(
                        controller: _usernameController,
                        hint: 'Tên đăng nhập',
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 12),
                      _AuthField(
                        controller: _emailController,
                        hint: 'Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),
                      _AuthField(
                        controller: _phoneController,
                        hint: 'Số điện thoại',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 12),
                      _AuthField(
                        controller: _passwordController,
                        hint: 'Mật khẩu',
                        icon: Icons.lock_outline,
                        obscure: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white54,
                            size: 20,
                          ),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Địa chỉ
                      _sectionLabel('Địa chỉ'),
                      const SizedBox(height: 10),
                      _AuthField(
                        controller: _streetController,
                        hint: 'Số nhà, tên đường',
                        icon: Icons.home_outlined,
                      ),
                      const SizedBox(height: 12),
                      _AuthField(
                        controller: _districtController,
                        hint: 'Quận / Huyện',
                        icon: Icons.location_city_outlined,
                      ),
                      const SizedBox(height: 12),
                      _AuthField(
                        controller: _cityController,
                        hint: 'Thành phố / Tỉnh',
                        icon: Icons.map_outlined,
                      ),
                      const SizedBox(height: 12),
                      _AuthField(
                        controller: _countryController,
                        hint: 'Quốc gia',
                        icon: Icons.flag_outlined,
                      ),
                      const SizedBox(height: 24),

                      // Vai trò
                      _sectionLabel('Bạn là'),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.24)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedRole,
                            isExpanded: true,
                            dropdownColor: const Color(0xFF1A1A2E),
                            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white54),
                            items: _roles.map((role) {
                              return DropdownMenuItem<String>(
                                value: role,
                                child: Row(
                                  children: [
                                    Icon(
                                      role == 'Customer' ? Icons.person : Icons.store_outlined,
                                      color: Colors.blue,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      role == 'Customer' ? 'Khách hàng' : 'Người bán',
                                      style: const TextStyle(color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) setState(() => _selectedRole = value);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Nút đăng ký
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            disabledBackgroundColor: Colors.blue.withValues(alpha: 0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  'Đăng ký',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Đã có tài khoản
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Đã có tài khoản?',
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          TextButton(
                            onPressed: () => context.pop(),
                            child: const Text(
                              'Đăng nhập',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.6),
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
      ),
    );
  }

  Future<void> _handleRegister() async {
    final validations = <MapEntry<String, String>>[
      MapEntry(_usernameController.text.trim(), 'Vui lòng nhập tên đăng nhập'),
      MapEntry(_emailController.text.trim(), 'Vui lòng nhập email'),
      MapEntry(_phoneController.text.trim(), 'Vui lòng nhập số điện thoại'),
      MapEntry(_passwordController.text, 'Vui lòng nhập mật khẩu'),
      MapEntry(_streetController.text.trim(), 'Vui lòng nhập số nhà, tên đường'),
      MapEntry(_districtController.text.trim(), 'Vui lòng nhập quận / huyện'),
      MapEntry(_cityController.text.trim(), 'Vui lòng nhập thành phố / tỉnh'),
      MapEntry(_countryController.text.trim(), 'Vui lòng nhập quốc gia'),
    ];

    for (final entry in validations) {
      if (entry.key.isEmpty) {
        _showError(entry.value);
        return;
      }
    }

    setState(() => _isLoading = true);

    final authVM = Provider.of<AuthViewModel>(context, listen: false);

    try {
      final address = Address(
        street: _streetController.text.trim(),
        district: _districtController.text.trim(),
        city: _cityController.text.trim(),
        country: _countryController.text.trim(),
      );

      final response = await authVM.register(
        _usernameController.text.trim(),
        _selectedRole,
        _emailController.text.trim(),
        _phoneController.text.trim(),
        _passwordController.text,
        address,
      );

      if (!mounted) return;

      if (response['status'] == 'success') {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Đăng ký thành công'),
            content: const Text('Tài khoản đã được tạo. Vui lòng đăng nhập.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  context.pop();
                },
                child: const Text('Đăng nhập ngay'),
              ),
            ],
          ),
        );
      } else {
        _showError('Đăng ký thất bại. Vui lòng thử lại.');
      }
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
    );
  }
}

class _AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const _AuthField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.38), fontSize: 15),
        prefixIcon: Icon(icon, color: Colors.white54, size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.08),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.24)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.24)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        ),
      ),
    );
  }
}
