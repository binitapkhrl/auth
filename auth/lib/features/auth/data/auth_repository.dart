import 'package:flutter_riverpod/flutter_riverpod.dart';
class AuthRepository {
  bool _isLoggedIn = false;
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

  Future<bool> signUp(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }

    // Dummy success response for signup
    return true;
  }
 
  Future<void> signOut() async {
    // Clear session, tokens, etc.
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoggedIn = false;
  }

  bool get isLoggedIn => _isLoggedIn;

  Future<void> resendOtp() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<bool> verifyOtp(String code) async {
    await Future.delayed(const Duration(seconds: 1));
    const validOtp = '123456';

    if (code == validOtp) {
      return true;
    }

    throw Exception('Invalid OTP. Please try again.');
  }
}

// Provide it
final authRepositoryProvider = Provider((ref) => AuthRepository());