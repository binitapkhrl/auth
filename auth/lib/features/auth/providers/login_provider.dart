import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';

/// Login Provider
final loginProvider =
    AsyncNotifierProvider<LoginNotifier, void>(LoginNotifier.new);

class LoginNotifier extends AsyncNotifier<void> {
  late final AuthRepository _authRepository;
  bool _loginAttempted = false;

  bool get loginAttempted => _loginAttempted;

  @override
  Future<void> build() async {
    _authRepository = ref.read(authRepositoryProvider);
    _loginAttempted = false;
    // Just initialize without changing state
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    _loginAttempted = true;
    state = const AsyncLoading();

    try {
      final isSuccess = await _authRepository.signIn(email, password);

      if (isSuccess) {
        state = const AsyncData(null);
      }
    } catch (e, stackTrace) {
      state = AsyncError(e.toString(), stackTrace);
    }
  }
}
