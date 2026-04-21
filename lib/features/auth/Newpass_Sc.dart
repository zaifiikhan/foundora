import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create New Password',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D6E7A)),
        useMaterial3: true,
      ),
      home: const CreateNewPasswordScreen(),
    );
  }
}

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _newPassVisible = false;
  bool _confirmPassVisible = false;
  bool _isLoading = false;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  // ── Colors ─────────────────────────────────────────────────────────────────
  static const Color _headerBg    = Color(0xFF0D6E7A);
  static const Color _cardBg      = Color(0xFFCFE8EC);
  static const Color _buttonColor = Color(0xFF0D5F6B);
  static const Color _bigCircle   = Color(0xFF5BAEBA);
  static const Color _shadowBlob  = Color(0xFF7EC8D0);

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.10),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));
    _animController.forward();
  }

  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    _animController.dispose();
    super.dispose();
  }

  bool get _isValid {
    final pass = _newPassController.text;
    return pass.length >= 6 && pass.contains(RegExp(r'[0-9]'));
  }

  Future<void> _onSave() async {
    if (_newPassController.text.isEmpty || _confirmPassController.text.isEmpty) {
      _showSnack('Please fill in both fields');
      return;
    }
    if (!_isValid) {
      _showSnack('Password must be at least 6 chars & contain a number');
      return;
    }
    if (_newPassController.text != _confirmPassController.text) {
      _showSnack('Passwords do not match');
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isLoading = false);
      _showSnack('Password saved successfully!');
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: const Color(0xFF0D5F6B),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: _headerBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: _buildCard(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      color: _headerBg,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 52, bottom: 28, left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          const SizedBox(height: 18),
          // Title
          const Text(
            'Create New Password',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 10),
          // Subtitle
          const Text(
            'Your New Password Must Be Differnt\nFrom Priviously Used Password:',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  // ── Card ─────────────────────────────────────────────────────────────────────
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),

            // ── Password Illustration ────────────────────────────────────────
            Center(child: _buildIllustration()),

            const SizedBox(height: 32),

            // ── New Password ─────────────────────────────────────────────────
            const Text(
              'New Password',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A3A40),
              ),
            ),
            const SizedBox(height: 10),
            _buildPasswordField(
              controller: _newPassController,
              hint: '••••••••',
              isVisible: _newPassVisible,
              onToggle: () =>
                  setState(() => _newPassVisible = !_newPassVisible),
            ),

            const SizedBox(height: 20),

            // ── Confirm Password ─────────────────────────────────────────────
            const Text(
              'Confirm Password',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A3A40),
              ),
            ),
            const SizedBox(height: 10),
            _buildPasswordField(
              controller: _confirmPassController,
              hint: '••••••••',
              isVisible: _confirmPassVisible,
              onToggle: () =>
                  setState(() => _confirmPassVisible = !_confirmPassVisible),
            ),

            const SizedBox(height: 20),

            // ── Password Rule hint ───────────────────────────────────────────
            _buildPasswordRule(),

            const SizedBox(height: 28),

            // ── Save Button ──────────────────────────────────────────────────
            _buildSaveButton(),

            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  // ── Illustration: password field with checkmark + layered teal circles ───────
  Widget _buildIllustration() {
    return SizedBox(
      width: 220,
      height: 170,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Shadow blob (offset bottom-right) ────────────────────────────
          Positioned(
            right: 10,
            bottom: 10,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _shadowBlob.withOpacity(0.50),
              ),
            ),
          ),

          // ── Big teal filled circle (centered) ────────────────────────────
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _bigCircle.withOpacity(0.70),
            ),
          ),

          // ── Inner lighter circle ──────────────────────────────────────────
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF8DD4DB).withOpacity(0.60),
            ),
          ),

          // ── Password bar illustration (custom painter) ────────────────────
          CustomPaint(
            size: const Size(160, 80),
            painter: _PasswordIllustrationPainter(),
          ),
        ],
      ),
    );
  }

  // ── Password Field ────────────────────────────────────────────────────────────
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool isVisible,
    required VoidCallback onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
        controller: controller,
        obscureText: !isVisible,
        style: const TextStyle(
          fontSize: 22,
          letterSpacing: 4,
          color: Color(0xFF1A3A40),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 22,
            letterSpacing: 4,
            color: Color(0xFFAAAAAA),
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: Icon(
              isVisible
                  ? Icons.remove_red_eye_outlined
                  : Icons.remove_red_eye_outlined,
              color: const Color(0xFF0D5F6B),
              size: 24,
            ),
            onPressed: onToggle,
          ),
        ),
      ),
    );
  }

  // ── Password Rule ─────────────────────────────────────────────────────────────
  Widget _buildPasswordRule() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Teal checkbox
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: const Color(0xFF0D5F6B),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 15,
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Password must contain:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A3A40),
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Atleast 6 characters & Atleast one number',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF4A6A70),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Save Button ───────────────────────────────────────────────────────────────
  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _onSave,
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
          'Save',
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

// ── Password Illustration Painter ─────────────────────────────────────────────
// Draws a rounded password input bar with dots + a checkmark swoosh on the right
class _PasswordIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final darkPaint = Paint()
      ..color = const Color(0xFF1A3A40)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = const Color(0xFF1A3A40)
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // ── Rounded rectangle (password bar) ──────────────────────────────────
    final barRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx - 10, cy + 6),
        width: 120,
        height: 38,
      ),
      const Radius.circular(10),
    );
    canvas.drawRRect(barRect, darkPaint);

    // ── Dots inside bar ────────────────────────────────────────────────────
    const dotCount = 6;
    const dotRadius = 3.5;
    const dotSpacing = 14.0;
    final startX = cx - 10 - ((dotCount - 1) * dotSpacing) / 2;
    for (int i = 0; i < dotCount; i++) {
      canvas.drawCircle(
        Offset(startX + i * dotSpacing, cy + 6),
        dotRadius,
        fillPaint,
      );
    }

    // ── Checkmark swoosh (top-right of bar) ────────────────────────────────
    final checkPaint = Paint()
      ..color = const Color(0xFF1A3A40)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Tick: small left leg + longer right leg
    final tickX = cx + 46.0;
    final tickY = cy - 10.0;

    final tickPath = Path()
      ..moveTo(tickX - 8, tickY)
      ..lineTo(tickX - 2, tickY + 7)
      ..lineTo(tickX + 10, tickY - 8);
    canvas.drawPath(tickPath, checkPaint);

    // Small motion lines near checkmark (speed dashes)
    final dashPaint = Paint()
      ..color = const Color(0xFF1A3A40)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    // Top-left dash
    canvas.drawLine(
      Offset(tickX - 22, tickY - 10),
      Offset(tickX - 14, tickY - 6),
      dashPaint,
    );
    // Middle dash
    canvas.drawLine(
      Offset(tickX - 24, tickY - 1),
      Offset(tickX - 15, tickY - 1),
      dashPaint,
    );
    // Bottom dash
    canvas.drawLine(
      Offset(tickX - 22, tickY + 8),
      Offset(tickX - 14, tickY + 5),
      dashPaint,
    );
  }

  @override
  bool shouldRepaint(_PasswordIllustrationPainter old) => false;
}