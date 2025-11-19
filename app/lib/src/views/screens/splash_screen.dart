import 'package:app/src/views/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/splash_view_model.dart';
import '../../utils/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _initializeApp(SplashViewModel viewModel) async {
    await viewModel.initialize();

    if (mounted && viewModel.isInitialized) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignupScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashViewModel(),
      builder: (context, child) {
        return Consumer<SplashViewModel>(
          builder: (context, viewModel, child) {
            // Initialize app after the provider is available
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!viewModel.isLoading &&
                  !viewModel.isInitialized &&
                  viewModel.error == null) {
                _initializeApp(viewModel);
              }
            });

            return Scaffold(
              backgroundColor:
                  const Color(0xFFFFF9EC), // Light cream background from design
              body: Stack(
                children: [
                  // Background decorative elements
                  // Upper left corner decorative image
                  Positioned(
                    left: -22,
                    top: 4,
                    child: Opacity(
                      opacity: 0.05, // Very low opacity as in design
                      child: Image.asset(
                        'assets/images/image 3.png',
                        width: 190,
                        height: 231,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Bottom right corner decorative image
                  Positioned(
                    right: -22,
                    bottom: 50,
                    child: Opacity(
                      opacity: 0.05, // Very low opacity as in design
                      child: Image.asset(
                        'assets/images/image 3.png',
                        width: 190,
                        height: 231,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Main content
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        // Top navigation area (maintaining space from design)
                        Container(
                          height: 812,
                          width: 375,
                          alignment: Alignment.center,
                          child: Container(
                            height: 41,
                            width: 173,
                            decoration: const BoxDecoration(),
                            child: Image.asset(
                              'assets/images/gridsmart_logo.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback if image fails to load
                                return Container(
                                  height: 41,
                                  width: 173,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryOrange,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'GridSmart',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
