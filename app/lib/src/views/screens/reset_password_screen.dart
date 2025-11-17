import 'package:flutter/material.dart';
import '../widgets/app_background.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  bool get _canSavePassword {
    return _passwordController.text.isNotEmpty &&
           _confirmPasswordController.text.isNotEmpty &&
           _passwordController.text == _confirmPasswordController.text;
  }

  Future<void> _savePassword() async {
    if (!_canSavePassword) return;
    
    setState(() {
      _isLoading = true;
    });
    
    // TODO: Implement password reset logic
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isLoading = false;
    });
    
    if (mounted) {
      // TODO: Navigate to success screen or login
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo header
            const OnboardingHeader(),

            const SizedBox(height: 96),

            // Reset Password content
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  const Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF8B0A),
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Section with subtitle and description
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Subtitle
                        const Text(
                          'Create a new password',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF3D3936),
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Description
                        const Text(
                          'Your new password must be different from your previous password.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF3D3936),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password Input Field
                  CustomTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hintText: 'Enter password',
                    obscureText: !_isPasswordVisible,
                    keyboardType: TextInputType.text,
                    enableSuggestions: false,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: () {
                      _confirmPasswordFocusNode.requestFocus();
                    },
                    onChanged: (value) => setState(() {}),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: const Color(0xFF666666),
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Confirm Password Input Field
                  CustomTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    hintText: 'Confirm password',
                    obscureText: !_isConfirmPasswordVisible,
                    keyboardType: TextInputType.text,
                    enableSuggestions: false,
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: () => _savePassword(),
                    onChanged: (value) => setState(() {}),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: const Color(0xFF666666),
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Save Password button container
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                    width: double.infinity,
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _canSavePassword ? _savePassword : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF262626),
                          disabledBackgroundColor: const Color(0xFF666666),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Save Password',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF6FFEC),
                                  fontFamily: 'Inter',
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}