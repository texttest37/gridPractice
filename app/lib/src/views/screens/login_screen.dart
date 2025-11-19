import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/login_view_model.dart';
import '../../utils/constants/colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/social_login_button.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/app_background.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: const _LoginScreenContent(),
    );
  }
}

class _LoginScreenContent extends StatefulWidget {
  const _LoginScreenContent();

  @override
  State<_LoginScreenContent> createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<_LoginScreenContent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
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

            SizedBox(height: isSmallScreen ? 60 : 80),

            // Login form
            Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Login Title
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 32 : 40,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryOrange,
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 32 : 40),

                    // Email Field
                    CustomTextField(
                      controller: _emailController,
                      label: 'Email',
                      hintText: 'jd@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => viewModel.validateEmail(value),
                      enableSuggestions: true,
                      autocorrect: false, // Disable autocorrect for email
                      textInputAction: TextInputAction.next,
                    ),

                    SizedBox(height: isSmallScreen ? 16 : 20),

                    // Password Field
                    CustomTextField(
                      controller: _passwordController,
                      label: 'Password',
                      hintText: '***************',
                      obscureText: _obscurePassword,
                      validator: (value) => viewModel.validatePassword(value),
                      enableSuggestions: false,
                      autocorrect: false, // Disable autocorrect for password
                      textInputAction: TextInputAction.done,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 16 : 20),

                    // Remember me & Forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => viewModel.toggleRememberMe(),
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: viewModel.rememberMe
                                      ? AppColors.primaryOrange
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: viewModel.rememberMe
                                        ? AppColors.primaryOrange
                                        : AppColors.borderGray,
                                    width: 2,
                                  ),
                                ),
                                child: viewModel.rememberMe
                                    ? const Icon(
                                        Icons.check,
                                        size: 16,
                                        color: AppColors.white,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Remember me',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () => viewModel.forgotPassword(context),
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: isSmallScreen ? 24 : 32),

                    // Login Button
                    CustomButton(
                      text: 'Login',
                      onPressed: viewModel.isLoading
                          ? null
                          : () => _handleLogin(context, viewModel),
                      isLoading: viewModel.isLoading,
                    ),

                    SizedBox(height: isSmallScreen ? 24 : 32),

                    // Or divider
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(color: AppColors.borderLight)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        const Expanded(
                            child: Divider(color: AppColors.borderLight)),
                      ],
                    ),

                    SizedBox(height: isSmallScreen ? 24 : 32),

                    // Social Login Buttons
                    SocialLoginButton(
                      text: 'Continue with Google',
                      iconAsset: 'assets/images/google.png',
                      onPressed: viewModel.loginWithGoogle,
                    ),

                    SizedBox(height: isSmallScreen ? 16 : 20),

                    SocialLoginButton(
                      text: 'Continue with Apple',
                      icon: Icons.apple,
                      onPressed: viewModel.loginWithApple,
                    ),

                    SizedBox(height: isSmallScreen ? 32 : 40),

                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 16,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              color: AppColors.primaryOrange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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

  void _handleLogin(BuildContext context, LoginViewModel viewModel) {
    if (_formKey.currentState?.validate() ?? false) {
      viewModel.login(
        _emailController.text,
        _passwordController.text,
        context,
      );
    }
  }
}
