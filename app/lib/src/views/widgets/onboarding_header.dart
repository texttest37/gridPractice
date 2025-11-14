import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  final double height;
  final double logoWidth;
  final double logoHeight;

  const OnboardingHeader({
    super.key,
    this.height = 102.0,
    this.logoWidth = 173.0,
    this.logoHeight = 41.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      alignment: Alignment.center,
      child: SizedBox(
        width: logoWidth,
        height: logoHeight,
        child: Image.asset(
          'assets/images/gridsmart_logo.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFF8B0A),
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
    );
  }
}