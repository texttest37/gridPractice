import 'package:flutter/material.dart';
import 'base_view_model.dart';
import '../views/screens/main_navigation_screen.dart';
import '../views/screens/forgot_password_screen.dart';

class LoginViewModel extends BaseViewModel {
  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  // Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  // Toggle remember me
  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  // Login with email and password
  Future<void> login(
      String email, String password, BuildContext context) async {
    setLoading(true);
    clearError();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with actual API call
      // final response = await authService.login(email, password);

      // For now, simulate successful login
      if (email.isNotEmpty && password.isNotEmpty) {
        // Navigate to main navigation screen (with bottom nav)
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
          );
        }
      } else {
        setError('Invalid credentials');
      }
    } catch (e) {
      setError('Login failed: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  // Login with Google
  Future<void> loginWithGoogle() async {
    setLoading(true);
    clearError();

    try {
      // TODO: Implement Google Sign-In
      await Future.delayed(const Duration(seconds: 1));
      // final response = await authService.loginWithGoogle();
      setError('Google Sign-In not implemented yet');
    } catch (e) {
      setError('Google login failed: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  // Login with Apple
  Future<void> loginWithApple() async {
    setLoading(true);
    clearError();

    try {
      // TODO: Implement Apple Sign-In
      await Future.delayed(const Duration(seconds: 1));
      // final response = await authService.loginWithApple();
      setError('Apple Sign-In not implemented yet');
    } catch (e) {
      setError('Apple login failed: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  // Forgot password
  void forgotPassword(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ForgotPasswordScreen(),
      ),
    );
  }

  // Navigate to sign up
  void navigateToSignUp() {
    // TODO: Navigate to sign up screen
    setError('Sign up feature coming soon');
  }
}
