import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foundora/features/auth/forget_pass/verify_sc.dart';
import 'verify_sc.dart'; // Added import for the 2nd screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forgot Password',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D6E7A)),
        useMaterial3: true,
      ),
      home: const ForgotPasswordScreen(),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isLoading = false;

  // ── Colors ──────────────────────────────────────────────────────────────────
  static const Color _headerBg = Color(0xFF0D6E7A);
  static const Color _cardBg = Color(0xFFD6E8EC);
  static const Color _buttonColor = Color(0xFF0D5F6B);
  static const Color _iconCircleColor = Color(0xFFB8D4DB);
  static const Color _textFieldBg = Colors.white;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _onDone() async {
    // Basic check to ensure the field isn't empty and looks somewhat like an email
    final emailText = _emailController.text.trim();
    if (emailText.isEmpty || !emailText.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: Color(0xFF0D5F6B),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    // Simulate network call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);

      // Navigate to the Verify Screen and pass the email address
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyScreen(email: emailText),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Make status bar icons light on the dark teal header
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: _headerBg,
      body: Column(
        children: [
          // ── Header ─────────────────────────────────────────────────────────
          _buildHeader(),

          // ── Card ───────────────────────────────────────────────────────────
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

  // ── Header ──────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      color: _headerBg,
      padding: const EdgeInsets.only(top: 60, bottom: 32, left: 24, right: 24),
      width: double.infinity,
      child: Column(
        children: const [
          Text(
            'Verification',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please enter your new password',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // ── Card ────────────────────────────────────────────────────────────────────
  Widget _buildCard() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // ── Lock Icon ────────────────────────────────────────────────────
                  _buildLockIcon(),

                  const SizedBox(height: 40),

                  // ── Email Label ──────────────────────────────────────────────────
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Enter your email address',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ── Text Field ───────────────────────────────────────────────────
                  _buildEmailField(),

                  const Spacer(),
                  const SizedBox(height: 20),

                  // ── Done Button ──────────────────────────────────────────────────
                  _buildDoneButton(),

                  const SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Lock Icon ────────────────────────────────────────────────────────────────
  Widget _buildLockIcon() {
    return SizedBox(
      height: 140,
      width: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer blurred circle
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _iconCircleColor.withOpacity(0.5),
            ),
          ),
          // Inner solid circle
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _iconCircleColor.withOpacity(0.8),
            ),
          ),
          // Lock icon
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Icon(
                Icons.mail_outline_rounded,
                color: Color(0xFF4DB8C8),
                size: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Email Field ──────────────────────────────────────────────────────────────
  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        color: _textFieldBg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _emailController,
        focusNode: _focusNode,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF1A1A2E),
        ),
        decoration: InputDecoration(
          hintText: 'Your Email',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: _textFieldBg,
        ),
      ),
    );
  }

  // ── Done Button ──────────────────────────────────────────────────────────────
  Widget _buildDoneButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _onDone,
        style: ElevatedButton.styleFrom(
          backgroundColor: _buttonColor,
          disabledBackgroundColor: _buttonColor.withOpacity(0.6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 2,
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
          'Done',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}