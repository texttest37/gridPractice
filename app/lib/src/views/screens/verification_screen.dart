import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/verification_view_model.dart';
import '../widgets/app_background.dart';
import '../widgets/onboarding_header.dart';
import 'verification_success_screen.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  
  const VerificationScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VerificationViewModel()
        ..setEmail(widget.email)
        ..startTimer(),
      builder: (context, child) {
        return Consumer<VerificationViewModel>(
          builder: (context, viewModel, child) {
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

                    // Verification content
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Title
                          const Text(
                            'Verification Code',
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
                                  'Enter Verification code',
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
                                  'We\'ve sent a verification code to your email. Please enter the code below to proceed.',
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

                          // Single Verification Code Input Field
                          Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: TextFormField(
                              controller: viewModel.otpControllers[0],
                              focusNode: viewModel.otpFocusNodes[0],
                              keyboardType: TextInputType.text,
                              maxLength: 6,
                              enableSuggestions: false,
                              autocorrect: false,
                              textInputAction: TextInputAction.done,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF4D4D4D),
                                fontFamily: 'Poppins',
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                counterText: '',
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                hintText: 'Enter verification code',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF666666),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              onChanged: (value) => viewModel.onSingleOtpChanged(value),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Verify button container
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                            width: double.infinity,
                            child: SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: viewModel.canVerify
                                    ? () async {
                                        final success = await viewModel.verifyCode();
                                        if (success && context.mounted) {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const VerificationSuccessScreen(),
                                            ),
                                          );
                                        }
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF262626),
                                  disabledBackgroundColor: const Color(0xFF666666),
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
                                        'Verify',
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
                          const SizedBox(height: 16),

                          // Resend button
                          SizedBox(
                            height: 48,
                            child: TextButton(
                              onPressed: viewModel.canResend ? viewModel.resendCode : null,
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 32),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'RESEND CODE ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFFFF7200),
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    TextSpan(
                                      text: '(${viewModel.formattedTime})',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: const Color(0xFFFF7200),
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
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
          },
        );
      },
    );
  }

}