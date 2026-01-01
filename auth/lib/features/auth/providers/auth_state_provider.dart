import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

final authStateProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return AuthNotifier(repo);
});

class AuthNotifier extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  AuthNotifier(this._authRepository) : super(_authRepository.isLoggedIn);

  Future<void> logout() async {
    await _authRepository.signOut();
    state = false;
  }

  Future<void> login(String email, String password) async {
    final success = await _authRepository.signIn(email, password);
    state = success;
  }
}
