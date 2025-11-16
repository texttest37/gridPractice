import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/signup_view_model.dart';
import '../widgets/app_background.dart';
import '../widgets/onboarding_header.dart';
import 'verification_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupViewModel(),
      builder: (context, child) {
        return Consumer<SignupViewModel>(
          builder: (context, viewModel, child) {
            return AppBackground(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth > 600 ? 48.0 : 24.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logo header
                        const OnboardingHeader(),

                        const SizedBox(height: 96),

                        // Signup form
                        Container(
                          width: constraints.maxWidth > 600
                              ? 400.0
                              : double.infinity,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFF8B0A),
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Input fields
                                Column(
                                  children: [
                                    _buildTextField(
                                      controller: viewModel.firstNameController,
                                      labelText: 'First Name',
                                      hintText: 'John',
                                      textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'First name is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    _buildTextField(
                                      controller: viewModel.lastNameController,
                                      labelText: 'Last Name',
                                      hintText: 'Doe',
                                      textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Last name is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    _buildTextField(
                                      controller: viewModel.emailController,
                                      labelText: 'Email',
                                      hintText: 'jd@gmail.com',
                                      keyboardType: TextInputType.emailAddress,
                                      validator: viewModel.validateEmail,
                                      enableSuggestions: true,
                                      autocorrect: false, // Disable autocorrect for email
                                      textInputAction: TextInputAction.next,
                                    ),
                                    _buildTextField(
                                      controller: viewModel.passwordController,
                                      labelText: 'Password',
                                      hintText: '123456',
                                      obscureText: !viewModel.isPasswordVisible,
                                      validator: viewModel.validatePassword,
                                      enableSuggestions: false,
                                      autocorrect: false, // Disable autocorrect for password
                                      textInputAction: TextInputAction.next,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          viewModel.isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: const Color(0xFF666666),
                                          size: 20,
                                        ),
                                        onPressed:
                                            viewModel.togglePasswordVisibility,
                                      ),
                                    ),
                                    _buildTextField(
                                      controller:
                                          viewModel.confirmPasswordController,
                                      labelText: 'Confirm Password',
                                      hintText: '**************',
                                      obscureText:
                                          !viewModel.isConfirmPasswordVisible,
                                      validator:
                                          viewModel.validateConfirmPassword,
                                      enableSuggestions: false,
                                      autocorrect: false, // Disable autocorrect for confirm password
                                      textInputAction: TextInputAction.done,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          viewModel.isConfirmPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: const Color(0xFF666666),
                                          size: 20,
                                        ),
                                        onPressed: viewModel
                                            .toggleConfirmPasswordVisibility,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // Sign Up button
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed: viewModel.canSignUp &&
                                            !viewModel.isLoading
                                        ? () async {
                                            // Always validate to show errors
                                            final isValid = _formKey
                                                .currentState!
                                                .validate();

                                            // Only proceed with signup if validation passes
                                            if (isValid) {
                                              await viewModel.signUp();
                                              // Navigate to verification screen after successful signup
                                              if (mounted &&
                                                  viewModel.error == null) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        VerificationScreen(
                                                      email: viewModel
                                                          .emailController.text,
                                                    ),
                                                  ),
                                                );
                                              }
                                            }
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF262626),
                                      disabledBackgroundColor:
                                          const Color(0xFF666666),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: viewModel.isLoading
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : const Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFF6FFEC),
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                const Text('Or'),
                                const SizedBox(height: 16),

                                // Google sign-in button
                                SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: OutlinedButton(
                                    onPressed: viewModel.signInWithGoogle,
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                          color: Color(0xFFE4E4E7)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset(
                                            'assets/images/google.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Continue with Google',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF52525B),
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Apple sign-in
                                SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: OutlinedButton(
                                    onPressed: viewModel.signInWithApple,
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                          color: Color(0xFFE4E4E7)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.apple, color: Colors.black),
                                        SizedBox(width: 8),
                                        Text(
                                          'Continue with Apple',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF52525B),
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Already have account
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Already have an account?',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF575757),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => const LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Sign In',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFFFF7200),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // Terms
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: viewModel.toggleTermsAcceptance,
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xFFFFA632),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: viewModel.isTermsAccepted
                                              ? const Color(0xFFFFA632)
                                              : Colors.transparent,
                                        ),
                                        child: viewModel.isTermsAccepted
                                            ? const Icon(
                                                Icons.check,
                                                size: 12,
                                                color: Colors.white,
                                              )
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Expanded(
                                      child: Text(
                                        'I agree to the Privacy Policy and Terms of Service.',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF221F20),
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
    Widget? suffixIcon,
    bool enableSuggestions = true,
    bool autocorrect = true,
    TextInputAction? textInputAction,
    VoidCallback? onFieldSubmitted,
  }) {
    return _CustomTextField(
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      suffixIcon: suffixIcon,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}

class _CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool enableSuggestions;
  final bool autocorrect;
  final TextInputAction? textInputAction;
  final VoidCallback? onFieldSubmitted;

  const _CustomTextField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  State<_CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<_CustomTextField> {
  String? _errorText;

  @override
  void initState() {
    super.initState();
    // No automatic validation - only validate on form submission
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            decoration: const BoxDecoration(
              color: Color(0xFFF7F7F7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              enableSuggestions: widget.enableSuggestions,
              autocorrect: widget.autocorrect,
              textInputAction: widget.textInputAction ?? TextInputAction.next,
              onFieldSubmitted: (_) => widget.onFieldSubmitted?.call(),
              validator: (value) {
                final error = widget.validator?.call(value);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted && error != _errorText) {
                    setState(() {
                      _errorText = error;
                    });
                  }
                });
                return error; // Return the actual error for form validation
              },
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                color: Color(0xFF4D4D4D),
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                labelText: widget.labelText,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w400,
                ),
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Color(0xFF4D4D4D),
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: widget.suffixIcon,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                errorStyle: const TextStyle(
                    height: 0, fontSize: 0), // Hide default error
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: const Color(0xFF666666),
          ),
          // Reserved space for error message (always present)
          Container(
            height: 20,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: _errorText != null && _errorText!.isNotEmpty
                ? Text(
                    _errorText!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
