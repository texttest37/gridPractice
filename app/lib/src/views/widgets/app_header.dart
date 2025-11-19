import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback? onNotificationTap;

  const AppHeader({
    super.key,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // GridSmart Logo
          Image.asset(
            'assets/images/gridsmart_logo.png',
            height: 32,
            fit: BoxFit.contain,
          ),
          // Notification Bell Icon
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: AppColors.textSecondary,
              size: 28,
            ),
            onPressed: onNotificationTap ?? () {
              // Default behavior - can be overridden
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
