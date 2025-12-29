import 'package:flutter_riverpod/flutter_riverpod.dart';
class AuthRepository {
  Future<bool> signIn(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    const validEmail = "test@test.com";
    const validPassword = "password123";

    if (  email == validEmail && password == validPassword) {
      return true;
    } else {
      throw Exception("Invalid email, or password.   test@test.com / password123");
    }
  }
}

// Provide it
final authRepositoryProvider = Provider((ref) => AuthRepository());