import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Newpass_Sc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D6E7A)),
        useMaterial3: true,
      ),
      home: const VerificationScreen(email: 'khusishahsyeda@gmail.com'),
    );
  }
}

class VerificationScreen extends StatefulWidget {
  final String email;
  const VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with SingleTickerProviderStateMixin {
  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  bool _isLoading = false;

  static const Color _headerBg = Color(0xFF0D6E7A);
  static const Color _cardBg = Color(0xFFD0E8ED);
  static const Color _buttonColor = Color(0xFF0D5F6B);

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.10),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));
    _animController.forward();
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  String get _enteredOtp => _controllers.map((c) => c.text).join();

  Future<void> _onVerify() async {
    if (_enteredOtp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the 4-digit code'),
          backgroundColor: Color(0xFF0D5F6B),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);

      // NAVIGATION ADDED HERE:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateNewPasswordScreen(),
        ),
      );
    }
  }

  void _onResend() {
    for (final c in _controllers) c.clear();
    _focusNodes[0].requestFocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code resent!'),
        backgroundColor: Color(0xFF0D5F6B),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: _headerBg,
      body: SingleChildScrollView( // FIXED: Scroll setup
        child: Column(
          children: [
            _buildHeader(context),
            // Fade & Slide wrapping the card directly without Expanded
            FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: _buildCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: _headerBg,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 52, bottom: 28, left: 16, right: 24),
      child: Column( // Simplified header to avoid stack issues in scroll
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Check Your phone',
            style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text("we've send the code to your phone", style: TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - 150), // FIXED: Height issue
      decoration: const BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            const SizedBox(height: 36),
            _buildCheckIcon(),
            const SizedBox(height: 36),
            Text(
              'Please Enter the 4 Digit code sent to\n${widget.email}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 28),
            _buildOtpRow(),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: _onResend,
                child: const Text(
                  'Resend code',
                  style: TextStyle(
                    color: Color(0xFF0D5F6B),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60), // FIXED: Replaced Spacer with fixed height
            _buildVerifyButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ... (Rest of your helper widgets: _buildCheckIcon, _buildOtpRow, etc. stay exactly as they were)
  Widget _buildCheckIcon() {
    return SizedBox(
      width: 180,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: 8,
            bottom: 8,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6BBEC9).withOpacity(0.55),
              ),
            ),
          ),
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: const Color(0xFF1A3A40), width: 5),
            ),
          ),
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF5FB8C4)),
          ),
          Container(
            width: 96,
            height: 96,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF8DD0D8)),
          ),
          const Icon(Icons.check_rounded, size: 52, color: Color(0xFF1A3A40)),
        ],
      ),
    );
  }

  Widget _buildOtpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (i) => _buildOtpBox(i)),
    );
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 62,
      height: 62,
      child: Stack(
        children: [
          CustomPaint(
            size: const Size(62, 62),
            painter: _CornerBracketPainter(
              color: const Color(0xFF0D5F6B),
              strokeWidth: 2.5,
              bracketLength: 14,
            ),
          ),
          TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A3A40)),
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
              fillColor: Colors.transparent,
              filled: true,
              contentPadding: EdgeInsets.only(bottom: 4),
            ),
            onChanged: (value) => _onOtpChanged(value, index),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _onVerify,
        style: ElevatedButton.styleFrom(
          backgroundColor: _buttonColor,
          disabledBackgroundColor: _buttonColor.withOpacity(0.6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 2,
        ),
        child: _isLoading
            ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
            : const Text('Verify', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _CornerBracketPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double bracketLength;
  const _CornerBracketPainter({required this.color, required this.strokeWidth, required this.bracketLength});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeWidth = strokeWidth..style = PaintingStyle.stroke..strokeCap = StrokeCap.square;
    final w = size.width; final h = size.height; final l = bracketLength;
    canvas.drawLine(Offset(0, l), Offset(0, 0), paint); canvas.drawLine(Offset(0, 0), Offset(l, 0), paint);
    canvas.drawLine(Offset(w - l, 0), Offset(w, 0), paint); canvas.drawLine(Offset(w, 0), Offset(w, l), paint);
    canvas.drawLine(Offset(0, h - l), Offset(0, h), paint); canvas.drawLine(Offset(0, h), Offset(l, h), paint);
    canvas.drawLine(Offset(w - l, h), Offset(w, h), paint); canvas.drawLine(Offset(w, h), Offset(w, h - l), paint);
  }
  @override
  bool shouldRepaint(_CornerBracketPainter old) => true;
}