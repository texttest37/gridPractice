import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final String? iconAsset;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.text,
    this.icon,
    this.iconAsset,
    required this.onPressed,
  }) : assert(icon != null || iconAsset != null,
            'Either icon or iconAsset must be provided');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFE4E4E7)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconAsset != null)
              SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(
                  iconAsset!,
                  width: 20,
                  height: 20,
                ),
              )
            else if (icon != null)
              Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF52525B),
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
