import 'package:flutter/material.dart';
import 'package:auth/core/widgets/custom_submit_button.dart'; // Your reusable button
import 'package:auth/core/widgets/auth_container.dart';
import 'package:pinput/pinput.dart'; // Recommended package for OTP input
import 'dart:async';
import 'package:beamer/beamer.dart';
class OtpVerificationPage extends StatefulWidget {
  // final String email; // Passed from previous screen (masked for privacy)

  const OtpVerificationPage({
    super.key,
    // required this.email,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _otpController = TextEditingController();
  Timer? _timer;
  int _remainingSeconds = 60;
  bool _canResend = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _canResend = false;
    _remainingSeconds = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        setState(() => _canResend = true);
        timer.cancel();
      }
    });
  }

  void _resendOtp() {
    if (!_canResend) return;

    // TODO: Call your resend OTP API here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP resent successfully')),
    );

    setState(() {
      _errorMessage = null;
      _otpController.clear();
    });
    _startTimer();
  }

  void _verifyOtp() {
    final otp = _otpController.text.trim();

    if (otp.length != 6) {
      setState(() => _errorMessage = 'Please enter a valid 6-digit OTP');
      return;
    }

    // TODO: Call your verify OTP API here
    // On success: navigate to home or next screen
    // On failure: setState(() => _errorMessage = 'Invalid OTP. Please try again.');

    // Example failure simulation:
    setState(() => _errorMessage = 'Invalid OTP. Please try again.');
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryGold = theme.colorScheme.primary;
    final screenHeight = MediaQuery.of(context).size.height;

    // final maskedEmail = widget.email.replaceRange(3, widget.email.indexOf('@'), '*****');

  return Scaffold(
  backgroundColor: primaryGold,
  resizeToAvoidBottomInset: true,
  body: SafeArea(
    child: Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            children: [
              // Optional back button
              GestureDetector(
                onTap: () => Beamer.of(context).beamBack(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.arrow_back, size: 24, color: Colors.black),
                    SizedBox(width: 4),
                    Text(
                      'Back',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                child: AuthContainer(
                  title: 'Enter Verification Code',
                  subtitle: 'Check your email for the OTP',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Pinput(
                        controller: _otpController,
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
                            border: Border.all(color: primaryGold, width: 2),
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
                        onCompleted: (pin) => _verifyOtp(),
                      ),

                      const SizedBox(height: 24),

                      // Countdown + Resend
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Didn\'t receive code? ',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          GestureDetector(
                            onTap: _canResend ? _resendOtp : null,
                            child: Text(
                              'Resend OTP',
                              style: TextStyle(
                                color: _canResend
                                    ? primaryGold
                                    : Colors.grey.shade500,
                                fontWeight: FontWeight.w600,
                                decoration: _canResend
                                    ? TextDecoration.underline
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),

                      if (!_canResend) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Resend available in $_remainingSeconds seconds',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 14),
                        ),
                      ],

                      const SizedBox(height: 32),

                      // Error message
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      AppPrimaryButton(
                        text: 'Verify',
                        onPressed: _verifyOtp,
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