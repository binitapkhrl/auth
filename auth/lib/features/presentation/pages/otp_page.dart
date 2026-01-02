import 'dart:async';
import 'package:auth/core/widgets/auth_container.dart';
import 'package:auth/core/widgets/app_primary_button.dart';
import 'package:auth/features/auth/providers/otp_provider.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:auth/core/widgets/auth_header.dart';

class OtpVerificationPage extends HookConsumerWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final primaryGold = theme.colorScheme.primary;

    final otpState = ref.watch(otpProvider);
    final otpController = useTextEditingController();
    final scrollController = useScrollController();
    final remainingSeconds = useState(60);
    final canResend = useState(false);
    final errorMessage = useState<String?>(null);
    final timerRef = useRef<Timer?>(null);
    final wasResending = useRef(false);

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = keyboardHeight > 0;

    // Calculate approximate header height (adjust if needed)
    final headerHeight = 180.0;

    void startTimer() {
      canResend.value = false;
      remainingSeconds.value = 60;
      timerRef.value?.cancel();
      timerRef.value = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainingSeconds.value > 0) {
          remainingSeconds.value = remainingSeconds.value - 1;
        } else {
          canResend.value = true;
          timer.cancel();
        }
      });
    }

    useEffect(() {
      startTimer();
      return () {
        timerRef.value?.cancel();
      };
    }, const []);

    // Scroll behavior when keyboard appears/disappears
    useEffect(() {
      if (isKeyboardVisible) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              headerHeight,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
            );
          }
        });
      } else {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInCubic,
          );
        }
      }
      return null;
    }, [isKeyboardVisible]);

    // Listen to OTP provider state changes
    ref.listen<AsyncValue<void>>(otpProvider, (previous, next) {
      if (previous is AsyncLoading && next is AsyncData) {
        if (wasResending.value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP resent successfully')),
          );
          errorMessage.value = null;
          otpController.clear();
          startTimer();
          wasResending.value = false;
        } else {
          errorMessage.value = null;
          Beamer.of(context).beamToReplacementNamed('/home');
        }
      }

      if (next is AsyncError) {
        final error = next.error.toString();
        errorMessage.value = error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
        wasResending.value = false;
      }
    });

    void resendOtp() {
      if (!canResend.value || otpState.isLoading) return;
      wasResending.value = true;
      ref.read(otpProvider.notifier).resendOtp();
    }

    void verifyOtp() {
      final otp = otpController.text.trim();

      if (otp.length != 6) {
        errorMessage.value = 'Please enter a valid 6-digit OTP';
        return;
      }

      wasResending.value = false;
      ref.read(otpProvider.notifier).verifyOtp(code: otp);
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: primaryGold,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: CustomScrollView(
            controller: scrollController,
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    AuthHeader(
                      title: 'Verify OTP',
                      subtitle: 'We sent a 6-digit code to your phone \nPlease enter it below.',
                      onBack: () => Beamer.of(context).beamBack(),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  padding: EdgeInsets.only(
                    bottom: isKeyboardVisible ? keyboardHeight + 16 : 32,
                  ),
                  child: AuthContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (errorMessage.value != null) ...[
                          _buildErrorBox(errorMessage.value!),
                          const SizedBox(height: 16),
                        ],
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Code',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Pinput(
                          controller: otpController,
                          length: 6,
                          defaultPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          focusedPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: primaryGold,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          submittedPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: primaryGold.withAlpha(25),
                              border: Border.all(color: primaryGold),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          errorPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onCompleted: (pin) => verifyOtp(),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (!canResend.value)
                              Text(
                                'Remaining time ${remainingSeconds.value} s',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              )
                            else
                              const SizedBox.shrink(),
                            GestureDetector(
                              onTap: canResend.value ? resendOtp : null,
                              child: Text(
                                'Resend OTP',
                                style: TextStyle(
                                  color: canResend.value
                                      ? primaryGold
                                      : Colors.grey.shade500,
                                  fontWeight: FontWeight.w600,
                                  decoration: canResend.value
                                      ? TextDecoration.underline
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        AppPrimaryButton(
                          text: otpState.isLoading ? 'Verifying...' : 'Verify',
                          onPressed: otpState.isLoading ? null : verifyOtp,
                        ),
                        // Add extra spacing at the bottom to match login page content height
                        // This ensures the scroll animation works properly
                        const SizedBox(height: 140),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorBox(String msg) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                msg,
                style: TextStyle(color: Colors.red.shade700, fontSize: 14),
              ),
            ),
          ],
        ),
      );
}