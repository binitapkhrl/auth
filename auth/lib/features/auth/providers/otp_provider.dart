import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';

/// OTP provider handles resend and verify flows
final otpProvider = AsyncNotifierProvider<OtpNotifier, void>(OtpNotifier.new);

class OtpNotifier extends AsyncNotifier<void> {
  late final AuthRepository _authRepository;

  @override
  void build() {
    _authRepository = ref.watch(authRepositoryProvider);
  }

  /// Handles resending the OTP code
  Future<void> resendOtp() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _authRepository.resendOtp();
    });
  }

  /// Verifies the entered OTP code
  Future<void> verifyOtp({required String code}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final isVerified = await _authRepository.verifyOtp(code);
      if (!isVerified) {
        throw 'OTP verification failed';
      }
    });
  }
}