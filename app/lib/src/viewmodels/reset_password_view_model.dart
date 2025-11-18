import 'package:flutter/material.dart';
import 'base_view_model.dart';
import '../views/screens/password_reset_success_screen.dart';

class ResetPasswordViewModel extends BaseViewModel {
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    
    return null;
  }
  
  String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    
    return null;
  }
  
  Future<void> resetPassword(String password, String confirmPassword, BuildContext context) async {
    setLoading(true);
    clearError();
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Replace with actual API call
      // final response = await authService.resetPassword(password);
      
      // For now, simulate successful reset
      if (password.isNotEmpty && confirmPassword.isNotEmpty && password == confirmPassword) {
        // Navigate to success screen with a small delay for UI stability
        if (context.mounted) {
          await Future.delayed(const Duration(milliseconds: 100));
          if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const PasswordResetSuccessScreen(),
              ),
            );
          }
        }
      } else {
        setError('Password reset failed');
      }
    } catch (e) {
      setError('Password reset failed: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }
}