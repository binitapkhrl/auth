import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';

/// OTP provider handles resend and verify flows
final otpProvider = AsyncNotifierProvider<OtpNotifier, void>(OtpNotifier.new);

class OtpNotifier extends AsyncNotifier<void> {
  late final AuthRepository _authRepository;

  @override
  Future<void> build() async {
    _authRepository = ref.read(authRepositoryProvider);
  }

  Future<void> resendOtp({
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    state = const AsyncLoading();
    try {
      await _authRepository.resendOtp();
      state = const AsyncData(null);
      onSuccess?.call();
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      onError?.call(e.toString());
    }
  }

  Future<void> verifyOtp({
    required String code,
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    state = const AsyncLoading();
    try {
      final ok = await _authRepository.verifyOtp(code);
      if (ok) {
        state = const AsyncData(null);
        onSuccess?.call();
      } else {
        const msg = 'OTP verification failed';
        state = const AsyncError(msg, StackTrace.empty);
        onError?.call(msg);
      }
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      onError?.call(e.toString());
    }
  }
}
