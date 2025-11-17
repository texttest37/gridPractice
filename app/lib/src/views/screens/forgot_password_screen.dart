import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/forgot_password_view_model.dart';
import '../../utils/constants/colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/app_background.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordViewModel(),
      child: const _ForgotPasswordScreenContent(),
    );
  }
}

class _ForgotPasswordScreenContent extends StatefulWidget {
  const _ForgotPasswordScreenContent();

  @override
  State<_ForgotPasswordScreenContent> createState() => _ForgotPasswordScreenContentState();
}

class _ForgotPasswordScreenContentState extends State<_ForgotPasswordScreenContent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ForgotPasswordViewModel>();
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

            SizedBox(height: isSmallScreen ? 100 : 120),

            // Forgot Password form
            Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Forgot Password Title
                    Text(
                      'Forgot Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 24 : 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryOrange,
                        fontFamily: 'Inter',
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 24 : 32),

                    // Enter your email subtitle
                    Text(
                      'Enter your email',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3D3936),
                        fontFamily: 'Inter',
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 8 : 12),

                    // Description text
                    Text(
                      'Enter your email to receive a verification code for password reset.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF3D3936),
                        fontFamily: 'Inter',
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 24 : 32),

                    // Email Field
                    CustomTextField(
                      controller: _emailController,
                      label: 'Email',
                      hintText: 'jd@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => viewModel.validateEmail(value),
                      enableSuggestions: true,
                      autocorrect: false,
                      textInputAction: TextInputAction.done,
                    ),

                    SizedBox(height: isSmallScreen ? 32 : 40),

                    // Send OTP Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomButton(
                        text: 'Send OTP',
                        onPressed: viewModel.isLoading
                            ? null
                            : () => _handleSendOTP(context, viewModel),
                        isLoading: viewModel.isLoading,
                      ),
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

  void _handleSendOTP(BuildContext context, ForgotPasswordViewModel viewModel) {
    if (_formKey.currentState?.validate() ?? false) {
      viewModel.sendOTP(_emailController.text, context);
    }
  }
}