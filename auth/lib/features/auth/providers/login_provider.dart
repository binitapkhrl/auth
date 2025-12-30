// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../data/auth_repository.dart';

// /// Login Provider
// final loginProvider =
//     AsyncNotifierProvider<LoginNotifier, void>(LoginNotifier.new);

// class LoginNotifier extends AsyncNotifier<void> {
//   late final AuthRepository _authRepository;
//   bool _loginAttempted = false;

//   bool get loginAttempted => _loginAttempted;

//   @override
//   Future<void> build() async {
//     _authRepository = ref.read(authRepositoryProvider);
//     _loginAttempted = false;
//     // Just initialize without changing state
//   }

//   Future<void> login({
//     required String email,
//     required String password,
//     Function()? onSuccess,
//     Function(String error)? onError,
//   }) async {
//     _loginAttempted = true;
//     state = const AsyncLoading();

//     try {
//       final isSuccess = await _authRepository.signIn(email, password);

//       if (isSuccess) {
//         state = const AsyncData(null);
//         onSuccess?.call();
//       }
//     } catch (e, stackTrace) {
//       state = AsyncError(e.toString(), stackTrace);
//       onError?.call(e.toString());
//     }
//   }
// }
// lib/features/auth/providers/login_provider.dart

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

    try {
      final success = await _authRepository.signIn(email, password);

      if (success) {
        state = const AsyncData(null); // Success
        onSuccess?.call();
      } else {
        final error = 'Login failed';
        state = const AsyncError('Login failed', StackTrace.empty);
        onError?.call(error);
      }
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      onError?.call(e.toString());
    }
  }
}