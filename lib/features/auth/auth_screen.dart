import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme.dart';
import '../../nav.dart'; // Added to access AppRouter.isAdmin
import 'forget_pass/forgot_Sc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  bool _isAdminMode = false; // Added state for admin toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              // Header
              Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Icon(
                      Icons.search_rounded,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    "Foundora",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    "Reconnecting lost belongings with their owners through AI matching.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Toggle
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isLogin = true),
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: _isLogin ? Theme.of(context).scaffoldBackgroundColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            boxShadow: _isLogin ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              )
                            ] : [],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Login",
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: _isLogin ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isLogin = false),
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: !_isLogin ? Theme.of(context).scaffoldBackgroundColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            boxShadow: !_isLogin ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              )
                            ] : [],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Sign Up",
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: !_isLogin ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Inputs
              _AuthInput(
                label: "Email Address",
                hint: "name@example.com",
                icon: Icons.email_outlined,
                isPassword: false,
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppSpacing.md),
              _AuthInput(
                label: "Password",
                hint: "••••••••",
                icon: Icons.lock_outlined,
                isPassword: true,
                inputType: TextInputType.visiblePassword,
              ),

              if (_isLogin) ...[
                const SizedBox(height: AppSpacing.xs),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordScreen()));
                    },
                    child: Text(
                      "Forgot Password?",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                const SizedBox(height: AppSpacing.md),
              ],

              const SizedBox(height: AppSpacing.lg),

              // Main Action Button (Updated with Admin routing and text)
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // MOCK AUTH: Set global admin state based on toggle
                    AppRouter.isAdmin = _isAdminMode;

                    if (_isAdminMode) {
                      context.go('/admin'); // Corrected path to exactly match nav.dart
                    } else {
                      context.go('/dashboard');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
                  ),
                  child: Text(
                    _isLogin
                        ? (_isAdminMode ? "Sign In to Admin Panel" : "Sign In to Foundora")
                        : (_isAdminMode ? "Create Admin Account" : "Create Account"),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              Row(
                children: [
                  Expanded(child: Divider(color: Theme.of(context).dividerColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Text(
                      "OR CONTINUE WITH",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Theme.of(context).dividerColor)),
                ],
              ),

              const SizedBox(height: AppSpacing.md),

              Row(
                children: [
                  Expanded(child: _SocialButton(label: "Google", icon: Icons.g_mobiledata)),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: _SocialButton(label: "Apple", icon: Icons.apple)),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),

              // Footer
              Column(
                children: [
                  // --- Admin Toggle Button ---
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isAdminMode = !_isAdminMode;
                      });
                    },
                    child: Text(
                      _isAdminMode
                          ? "Return to Student/User Login"
                          : (_isLogin ? "Login as an Admin" : "Sign up as an Admin"),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  // Standard Don't Have Account Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLogin ? "Don't have an account?" : "Already have an account?",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() => _isLogin = !_isLogin);
                        },
                        child: Text(
                          _isLogin ? "Create Account" : "Sign In",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Language Selector
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.language_rounded, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          "English",
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          height: 12,
                          width: 1,
                          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                          color: Theme.of(context).dividerColor,
                        ),
                        Text(
                          "اردو",
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthInput extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextInputType inputType;

  const _AuthInput({
    required this.label,
    required this.hint,
    required this.icon,
    required this.isPassword,
    required this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          obscureText: isPassword,
          keyboardType: inputType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Theme.of(context).hintColor),
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SocialButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}