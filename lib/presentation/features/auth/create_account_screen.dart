import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../widgets/mb_button.dart';
import '../../../l10n/generated/app_localizations.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
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
      appBar: AppBar(
        title: Text(l10n.createAccountTitle),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(l10n.fullName, style: AppTypography.labelMedium)
                  .animate()
                  .fadeIn(duration: 400.ms),
              const SizedBox(height: 8),
              TextField(controller: _nameCtrl)
                  .animate(delay: 60.ms)
                  .fadeIn(duration: 400.ms),
              const SizedBox(height: 20),
              Text(l10n.emailAddress, style: AppTypography.labelMedium)
                  .animate(delay: 120.ms)
                  .fadeIn(duration: 400.ms),
              const SizedBox(height: 8),
              TextField(controller: _emailCtrl, keyboardType: TextInputType.emailAddress)
                  .animate(delay: 180.ms)
                  .fadeIn(duration: 400.ms),
              const SizedBox(height: 20),
              Text(l10n.password, style: AppTypography.labelMedium)
                  .animate(delay: 240.ms)
                  .fadeIn(duration: 400.ms),
              const SizedBox(height: 8),
              TextField(
                controller: _passCtrl,
                obscureText: _obscurePass,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePass ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: AppColors.textSecondary),
                    onPressed: () => setState(() => _obscurePass = !_obscurePass),
                  ),
                ),
              ).animate(delay: 300.ms).fadeIn(duration: 400.ms),
              const SizedBox(height: 28),
              MBButton(
                label: l10n.createAccountSubmit,
                isLoading: _isLoading,
                onPressed: _submit,
              ).animate(delay: 360.ms).fadeIn(duration: 400.ms).slideY(begin: 0.3),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
