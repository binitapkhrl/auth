import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';

/// Provides the async state of the signup operation (loading, data, error)
final signupProvider = AsyncNotifierProvider<SignupNotifier, void>(SignupNotifier.new);

class SignupNotifier extends AsyncNotifier<void> {
  late final AuthRepository _authRepository;

  @override
  Future<void> build() async {
    _authRepository = ref.read(authRepositoryProvider);
  }

  Future<void> signUp({
    required String email,
    required String password,
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    state = const AsyncLoading();
    try {
      final success = await _authRepository.signUp(email, password);
      if (success) {
        state = const AsyncData(null);
        onSuccess?.call();
      } else {
        const error = 'Signup failed';
        state = const AsyncError(error, StackTrace.empty);
        onError?.call(error);
      }
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      onError?.call(e.toString());
    }
  }
}
