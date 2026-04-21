import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final Color _bgColor = const Color(0xFF116171);
  final Color _cardColor = const Color(0xFFE4EBEC);
  final Color _fieldTeal = const Color(0xFF176B7C);

  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.md),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
        ),
        title: const Text("Security", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password updated successfully"))),
            child: const Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(color: _cardColor, borderRadius: BorderRadius.circular(AppRadius.lg)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Change Password", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(height: 8),
              const Text("Update your password. Use at least 8 characters, including a number and symbol.",
                  style: TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(height: AppSpacing.lg),

              _buildPasswordField("Current Password", _currentPassController, _obscureCurrent, () => setState(() => _obscureCurrent = !_obscureCurrent)),
              const SizedBox(height: AppSpacing.md),
              _buildPasswordField("New Password", _newPassController, _obscureNew, () => setState(() => _obscureNew = !_obscureNew)),
              const SizedBox(height: AppSpacing.md),
              _buildPasswordField("Confirm New Password", _confirmPassController, _obscureConfirm, () => setState(() => _obscureConfirm = !_obscureConfirm)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool obscure, VoidCallback toggle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black // Labels are now black
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(color: Colors.white), // Input text remains white
          decoration: InputDecoration(
            filled: true,
            fillColor: _fieldTeal,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            suffixIcon: IconButton(
              icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: Colors.white70, size: 20),
              onPressed: toggle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFE4EBEC), border: Border(top: BorderSide(color: Colors.black12, width: 1))),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent, elevation: 0,
        selectedItemColor: _fieldTeal, unselectedItemColor: Colors.black87,
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI Match'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}