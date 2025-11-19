import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../widgets/app_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;
    final horizontalPadding = isSmallScreen ? 24.0 : size.width * 0.1;
    
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            AppHeader(
              onNotificationTap: () {
                // Handle notification tap
              },
            ),
            // Main Content with gray background
            Expanded(
              child: Container(
                color: const Color(0xFFF5F5F5), // Gray-50 background
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: isSmallScreen ? 24.0 : 32.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // "My Profile" Header
                      _buildProfileHeader(isSmallScreen),
                      SizedBox(height: isSmallScreen ? 16 : 20),
                      // User Profile Section
                      _buildUserProfileSection(isSmallScreen),
                      SizedBox(height: isSmallScreen ? 16 : 20),
                      // First Menu Section
                      _buildFirstMenuSection(),
                      SizedBox(height: isSmallScreen ? 16 : 20),
                      // Second Menu Section
                      _buildSecondMenuSection(),
                      SizedBox(height: isSmallScreen ? 16 : 20),
                      // Log out Button
                      _buildLogoutButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(bool isSmallScreen) {
    return Center(
      child: Text(
        'My Profile',
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: isSmallScreen ? 20 : 24,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF494949),
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildUserProfileSection(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 15.0 : 20.0),
      child: Row(
        children: [
          // Profile Avatar
          Container(
            width: isSmallScreen ? 55 : 65,
            height: isSmallScreen ? 55 : 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300,
            ),
            child: Icon(
              Icons.person,
              size: isSmallScreen ? 30 : 36,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(width: isSmallScreen ? 15 : 20),
          // User Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Siya Digra',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF494949),
                ),
              ),
              SizedBox(height: isSmallScreen ? 5 : 8),
              Text(
                'ID: 102996321',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: isSmallScreen ? 10 : 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF494949),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFirstMenuSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          _buildMenuItem(
            iconPath: 'assets/images/profile-icon 3.png',
            title: 'Account and Security',
            onTap: () {
              // Handle Account and Security tap
            },
          ),
          _buildMenuItem(
            iconPath: 'assets/images/property-icon 2.png',
            title: 'Manage Properties',
            onTap: () {
              // Handle Manage Properties tap
            },
          ),
          _buildMenuItem(
            iconPath: 'assets/images/device-management-icon 1.png',
            title: 'Manage Devices',
            onTap: () {
              // Handle Manage Devices tap
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSecondMenuSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          _buildMenuItem(
            iconPath: 'assets/images/notifications-icon 2.png',
            title: 'Notification Settings',
            onTap: () {
              // Handle Notification Settings tap
            },
          ),
          _buildMenuItem(
            iconPath: 'assets/images/permissions-icon 1.png',
            title: 'User Permissions',
            onTap: () {
              // Handle User Permissions tap
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String iconPath,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Icon
            Image.asset(
              iconPath,
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            // Title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  letterSpacing: 0.14,
                ),
              ),
            ),
            SizedBox(
              width: 6,
              height: 12,
              child: CustomPaint(
                painter: ChevronPainter(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        height: 35,
        child: InkWell(
          onTap: () {
            // Handle logout
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logout icon
                Icon(
                  Icons.logout,
                  size: 24,
                  color: const Color(0xFFFF3B30),
                ),
                const SizedBox(width: 5),
                // Logout text
                Text(
                  'Log out',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF3B30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom painter for chevron arrow with exact Figma dimensions
class ChevronPainter extends CustomPainter {
  final Color color;

  ChevronPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    
    // Draw chevron pointing right with exact dimensions
    // Starting from top-left, going to middle-right, then to bottom-left
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}