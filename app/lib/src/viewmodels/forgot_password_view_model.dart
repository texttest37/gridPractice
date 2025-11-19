import 'package:flutter/material.dart';
import 'base_view_model.dart';
import '../views/screens/verification_screen.dart';

class ForgotPasswordViewModel extends BaseViewModel {
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

  // Send OTP for password reset
  Future<void> sendOTP(String email, BuildContext context) async {
    setLoading(true);
    clearError();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with actual API call
      // final response = await authService.sendPasswordResetOTP(email);

      // For now, simulate successful OTP send
      if (email.isNotEmpty) {
        // Navigate to OTP verification screen with a small delay for UI stability
        if (context.mounted) {
          await Future.delayed(const Duration(milliseconds: 100));
          if (context.mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => VerificationScreen(
                  email: email,
                  flow: VerificationFlow.forgotPassword,
                ),
              ),
            );
          }
        }
      } else {
        setError('Invalid email address');
      }
    } catch (e) {
      setError('Failed to send OTP: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }
}