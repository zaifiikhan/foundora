import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmVisible = false;
  bool _isLoading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // ── Colors ──────────────────────────────────────────────────────────────────
  static const Color _headerBg = Color(0xFF0D6E7A);
  static const Color _cardBg = Color(0xFFD6E8EC);
  static const Color _buttonColor = Color(0xFF0D5F6B);
  static const Color _iconCircleColor = Color(0xFFB8D4DB);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));
    _animationController.forward();
  }

  @override
  void dispose() {
    _passController.dispose();
    _confirmPassController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    if (_passController.text != _confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // Simulate network
    if (mounted) {
      setState(() => _isLoading = false);
      // Navigate to Login or Home Screen here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully!'), backgroundColor: Color(0xFF0D5F6B)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: _headerBg,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildCard(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: _headerBg,
      padding: const EdgeInsets.only(top: 60, bottom: 32, left: 24, right: 24),
      width: double.infinity,
      child: Column(
        children: const [
          Text(
            'Create New Password',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Your new password must be different\nfrom previously used passwords.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Center(child: _buildPasswordIcon()),
                  const SizedBox(height: 30),

                  // New Password
                  Text('New Password', style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  _buildPasswordField(_passController, 'Enter new password', _isPasswordVisible, () {
                    setState(() => _isPasswordVisible = !_isPasswordVisible);
                  }),

                  const SizedBox(height: 20),

                  // Confirm Password
                  Text('Confirm Password', style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  _buildPasswordField(_confirmPassController, 'Confirm new password', _isConfirmVisible, () {
                    setState(() => _isConfirmVisible = !_isConfirmVisible);
                  }),

                  const SizedBox(height: 16),

                  // Checklist
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle, color: Color(0xFF1A1A2E), size: 18),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your Password must contain:', style: TextStyle(fontSize: 12, color: Colors.grey.shade800, fontWeight: FontWeight.w600)),
                          Text('At least 6 characters & 1 number', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                        ],
                      )
                    ],
                  ),

                  const Spacer(),
                  const SizedBox(height: 20),
                  _buildSaveButton(),
                  const SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordIcon() {
    return SizedBox(
      height: 120,
      width: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(width: 120, height: 120, decoration: BoxDecoration(shape: BoxShape.circle, color: _iconCircleColor.withOpacity(0.5))),
          Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, color: _iconCircleColor.withOpacity(0.8))),
          const Icon(Icons.password_rounded, color: Color(0xFF1A1A2E), size: 50),
        ],
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String hint, bool isVisible, VoidCallback onToggle) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        obscureText: !isVisible,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey.shade600),
            onPressed: onToggle,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _onSave,
        style: ElevatedButton.styleFrom(
          backgroundColor: _buttonColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Save', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
    );
  }
}