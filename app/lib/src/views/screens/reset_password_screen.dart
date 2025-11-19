import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/reset_password_view_model.dart';
import '../widgets/app_background.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPasswordViewModel(),
      child: const _ResetPasswordScreenContent(),
    );
  }
}

class _ResetPasswordScreenContent extends StatefulWidget {
  const _ResetPasswordScreenContent();

  @override
  State<_ResetPasswordScreenContent> createState() => _ResetPasswordScreenContentState();
}

class _ResetPasswordScreenContentState extends State<_ResetPasswordScreenContent> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _handleResetPassword(BuildContext context, ResetPasswordViewModel viewModel) {
    if (_formKey.currentState?.validate() ?? false) {
      viewModel.resetPassword(
        _passwordController.text,
        _confirmPasswordController.text,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ResetPasswordViewModel>();
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;
    final horizontalPadding = isSmallScreen ? 24.0 : size.width * 0.1;

    return AppBackground(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo header
            const OnboardingHeader(),

            SizedBox(height: isSmallScreen ? 80 : 96),

            // Reset Password content
            Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      'Reset Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 24 : 28,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFF8B0A),
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 24 : 32),

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
                      validator: (value) => viewModel.validatePassword(value),
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
                      focusNode: _confirmPasswordFocusNode,
                      label: 'Confirm Password',
                      hintText: 'Confirm password',
                      obscureText: !_isConfirmPasswordVisible,
                      keyboardType: TextInputType.text,
                      enableSuggestions: false,
                      autocorrect: false,
                      textInputAction: TextInputAction.done,
                      validator: (value) => viewModel.validateConfirmPassword(_passwordController.text, value),
                      onFieldSubmitted: () => _handleResetPassword(context, viewModel),
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

                    // Save Password button
                    SizedBox(height: isSmallScreen ? 20 : 24),

                    CustomButton(
                      text: 'Save Password',
                      onPressed: viewModel.isLoading
                          ? null
                          : () => _handleResetPassword(context, viewModel),
                      isLoading: viewModel.isLoading,
                    ),

                    SizedBox(height: isSmallScreen ? 24 : 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}