import 'package:flutter/material.dart';
import 'base_view_model.dart';

class SignupViewModel extends BaseViewModel {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isTermsAccepted = false;
  
  // Getters
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController => _confirmPasswordController;
  
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  bool get isTermsAccepted => _isTermsAccepted;
  
  // Methods
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }
  
  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }
  
  void toggleTermsAcceptance() {
    _isTermsAccepted = !_isTermsAccepted;
    notifyListeners();
  }
  
  bool get canSignUp {
    return _firstNameController.text.isNotEmpty &&
           _lastNameController.text.isNotEmpty &&
           _emailController.text.isNotEmpty &&
           _passwordController.text.isNotEmpty &&
           _confirmPasswordController.text.isNotEmpty &&
           _isTermsAccepted;
  }
  
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
  
  Future<void> signUp() async {
    if (!canSignUp) return;
    
    setLoading(true);
    
    try {
      // Simulate signup API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Add your signup logic here
      // For now, we'll just simulate success
      
    } catch (e) {
      setError('Signup failed: $e');
    } finally {
      setLoading(false);
    }
  }
  
  Future<void> signInWithGoogle() async {
    setLoading(true);
    
    try {
      // Simulate Google sign-in
      await Future.delayed(const Duration(seconds: 1));
      
      // Add Google sign-in logic here
      
    } catch (e) {
      setError('Google sign-in failed: $e');
    } finally {
      setLoading(false);
    }
  }
  
  Future<void> signInWithApple() async {
    setLoading(true);
    
    try {
      // Simulate Apple sign-in
      await Future.delayed(const Duration(seconds: 1));
      
      // Add Apple sign-in logic here
      
    } catch (e) {
      setError('Apple sign-in failed: $e');
    } finally {
      setLoading(false);
    }
  }
  
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}