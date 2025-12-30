import 'dart:async';
import 'package:auth/core/widgets/auth_container.dart';
import 'package:auth/core/widgets/custom_submit_button.dart'; // Your reusable button
import 'package:auth/features/auth/providers/otp_provider.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart'; // Recommended package for OTP input

class OtpVerificationPage extends HookConsumerWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final primaryGold = theme.colorScheme.primary;

    final otpState = ref.watch(otpProvider);
    final otpController = useTextEditingController();
    final remainingSeconds = useState(60);
    final canResend = useState(false);
    final errorMessage = useState<String?>(null);
    final timerRef = useRef<Timer?>(null);
    final wasResending = useRef(false);

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

    // Listen to OTP provider state changes
    ref.listen<AsyncValue<void>>(otpProvider, (previous, next) {
      if (previous is AsyncLoading && next is AsyncData) {
        // Success
        if (wasResending.value) {
          // Resend OTP succeeded
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP resent successfully')),
          );
          errorMessage.value = null;
          otpController.clear();
          startTimer();
          wasResending.value = false;
        } else {
          // Verify OTP succeeded
          errorMessage.value = null;
          Beamer.of(context).beamToReplacementNamed('/home');
        }
      }

      // Handle errors
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

    return Scaffold(
      backgroundColor: primaryGold,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button styled like SignUpPage
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Beamer.of(context).beamBack(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.arrow_back, size: 24, color: Colors.white),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Verify OTP',
                          style: theme.textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'We sent a 6-digit code to ****06@gmail.com', // or masked email
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // White card with OTP form
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    ),
                    child: AuthContainer(
                      title: 'Enter Verification Code',
                      subtitle: 'Check your email for the OTP',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
                          // Countdown + Resend aligned spaceBetween
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Left: timer when not allowed to resend
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

                              // Right: resend action
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

                          // Error message
                          if (errorMessage.value != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                errorMessage.value!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                          AppPrimaryButton(
                            text: otpState.isLoading ? 'Verifying...' : 'Verify',
                            onPressed: otpState.isLoading ? null : verifyOtp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
