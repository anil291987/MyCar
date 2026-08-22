import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../widgets/app_icon_mark.dart';
import '../../widgets/mb_button.dart';
import '../../../l10n/generated/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _signIn() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() => _isLoading = false);
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Center(
                child: const AppIconMark(size: 56),
              ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.7, 0.7)),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  l10n.brandName,
                  style: AppTypography.displayMedium,
                ),
              ).animate(delay: 200.ms).fadeIn(duration: 400.ms).slideY(begin: 0.2),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  l10n.signInSubtitle,
                  style: AppTypography.bodyMedium,
                ),
              ).animate(delay: 300.ms).fadeIn(duration: 400.ms),
              const SizedBox(height: 48),

              // Email
              Text(
                l10n.emailAddress,
                style: AppTypography.labelMedium,
              ).animate(delay: 400.ms).fadeIn(duration: 400.ms),
              const SizedBox(height: 8),
              TextField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                style: AppTypography.bodyLarge,
                decoration: InputDecoration(
                  hintText: 'your@email.com',
                  prefixIcon: Icon(Icons.email_outlined, color: AppColors.textTertiary, size: 20),
                ),
              ).animate(delay: 450.ms).fadeIn(duration: 400.ms).slideX(begin: -0.05),
              const SizedBox(height: 16),

              // Password
              Text(
                l10n.password,
                style: AppTypography.labelMedium,
              ).animate(delay: 500.ms).fadeIn(duration: 400.ms),
              const SizedBox(height: 8),
              TextField(
                controller: _passCtrl,
                obscureText: _obscurePass,
                style: AppTypography.bodyLarge,
                decoration: InputDecoration(
                  hintText: '••••••••',
                  prefixIcon: Icon(Icons.lock_outline, color: AppColors.textTertiary, size: 20),
                  suffixIcon: GestureDetector(
                    onTap: () => setState(() => _obscurePass = !_obscurePass),
                    child: Icon(
                      _obscurePass ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.textTertiary,
                      size: 20,
                    ),
                  ),
                ),
              ).animate(delay: 550.ms).fadeIn(duration: 400.ms).slideX(begin: -0.05),

              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.push('/forgot-password'),
                  child: Text(l10n.forgotPassword, style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.accentBlue,
                  )),
                ),
              ).animate(delay: 600.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 24),
              MBButton(
                label: l10n.signIn,
                isLoading: _isLoading,
                onPressed: _signIn,
              ).animate(delay: 650.ms).fadeIn(duration: 400.ms).slideY(begin: 0.3),

              const SizedBox(height: 16),
              MBButton(
                label: l10n.createMercedesMeId,
                isOutlined: true,
                onPressed: () => context.push('/create-account'),
              ).animate(delay: 700.ms).fadeIn(duration: 400.ms).slideY(begin: 0.3),

              const SizedBox(height: 40),
              Center(
                child: Text(
                  l10n.termsAndPrivacy,
                  textAlign: TextAlign.center,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ).animate(delay: 800.ms).fadeIn(duration: 400.ms),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
