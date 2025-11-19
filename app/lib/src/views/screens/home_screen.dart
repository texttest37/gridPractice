import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/home_view_model.dart';
import '../../utils/constants/colors.dart';
import '../widgets/app_background.dart';
import '../widgets/app_header.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: Column(
                children: [
                  // Custom Header
                  AppHeader(
                    onNotificationTap: () {
                      // Handle notification tap
                      // TODO: Navigate to notifications screen
                    },
                  ),
                  // Main Content
                  Expanded(
                    child: AppBackground(
                      topOffset: null, // No background shape for home screen
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Add Property Section
                            _buildAddPropertySection(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Navigation Bar
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: 0,
              onTap: (index) {
                // Handle navigation to different screens
                // TODO: Implement navigation logic
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddPropertySection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      // decoration: BoxDecoration(
      //   color: AppColors.white,
      //   borderRadius: BorderRadius.circular(12),
      //   border: Border.all(
      //     color: Colors.grey.shade300,
      //     width: 1,
      //   ),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add Property Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 161,
                height: 64,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.grey.shade600,
                        size: 25,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Add Property',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.grey.shade600,
                  size: 25,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Property Type Icons
          Row(
            children: [
              _buildPropertyTypeIcon(
                imagePath: 'assets/images/solarCycleGray.png',
                onTap: () {
                  // TODO: Handle residential property addition
                },
              ),
              const SizedBox(width: 16),
              _buildPropertyTypeIcon(
                imagePath: 'assets/images/energyPlanGray.png',
                onTap: () {
                  // TODO: Handle commercial property addition
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyTypeIcon({
    IconData? icon,
    String? imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        child: imagePath != null && imagePath.isNotEmpty
            ? ClipOval(
                child: Image.asset(
                  imagePath,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              )
            : Icon(
                icon ?? Icons.home,
                color: Colors.grey.shade500,
                size: 24,
              ),
      ),
    );
  }
}
