import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/app_background.dart';
import '../widgets/custom_button.dart';
import 'main_navigation_screen.dart';

class VerificationSuccessScreen extends StatelessWidget {
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return AppBackground(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 24.0 : size.width * 0.1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo header
            const OnboardingHeader(),

            SizedBox(height: isSmallScreen ? 120 : 160),

            // Success content
            Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    'Verification Code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 32 : 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryOrange,
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 48 : 64),

                  // Success icon
                  Container(
                    width: isSmallScreen ? 100 : 120,
                    height: isSmallScreen ? 100 : 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryOrange,
                    ),
                    child: Icon(
                      Icons.check,
                      size: isSmallScreen ? 60 : 72,
                      color: AppColors.white,
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 32 : 40),

                  // Success message
                  Text(
                    "You're in!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 28 : 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 16 : 20),

                  // Success description
                  Text(
                    'Verification Successful',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 48 : 64),

                  // Continue button
                  CustomButton(
                    text: 'Continue',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const MainNavigationScreen(),
                        ),
                      );
                    },
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
