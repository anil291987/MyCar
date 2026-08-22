import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../widgets/mb_button.dart';
import '../../../l10n/generated/app_localizations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailCtrl = TextEditingController();
  bool _isLoading = false;
  bool _sent = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {
        _isLoading = false;
        _sent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.forgotPasswordTitle),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              if (_sent) ...[
                Icon(Icons.mark_email_read_outlined, size: 48, color: AppColors.success)
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .scale(begin: const Offset(0.7, 0.7)),
                const SizedBox(height: 16),
                Text(l10n.forgotPasswordSent, style: AppTypography.bodyLarge)
                    .animate(delay: 100.ms)
                    .fadeIn(duration: 400.ms),
                const SizedBox(height: 24),
                MBButton(
                  label: l10n.backToSignIn,
                  onPressed: () => Navigator.pop(context),
                ).animate(delay: 200.ms).fadeIn(duration: 400.ms),
              ] else ...[
                Text(l10n.forgotPasswordSubtitle, style: AppTypography.bodyLarge)
                    .animate()
                    .fadeIn(duration: 400.ms),
                const SizedBox(height: 24),
                Text(l10n.emailAddress, style: AppTypography.labelMedium),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ).animate(delay: 100.ms).fadeIn(duration: 400.ms),
                const SizedBox(height: 24),
                MBButton(
                  label: l10n.forgotPasswordSend,
                  isLoading: _isLoading,
                  onPressed: _submit,
                ).animate(delay: 200.ms).fadeIn(duration: 400.ms),
              ],
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
