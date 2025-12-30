import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';

/// Provides the async state of the login operation (loading, data, error)
final loginProvider = AsyncNotifierProvider<LoginNotifier, void>(LoginNotifier.new);

class LoginNotifier extends AsyncNotifier<void> {
  late final AuthRepository _authRepository;

  @override
  Future<void> build() async {
    _authRepository = ref.read(authRepositoryProvider);
    // Initial state: idle (no value)
  }

  /// Performs the login with email and password
  Future<void> login({
    required String email,
    required String password,
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
    final success = await _authRepository.signIn(email, password);
    if (!success) throw Exception('Login failed');
    // return null; // This becomes AsyncData(null)
  });
  }
}