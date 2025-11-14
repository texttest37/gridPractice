import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final double? topOffset;
  final ScrollController? scrollController;

  const AppBackground({
    super.key,
    required this.child,
    this.topOffset = 118,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Gray-50 background
      body: SafeArea(
        child: Stack(
          children: [
            // Background shape - positioned and centered
            if (topOffset != null)
              Positioned(
                top: topOffset!,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width + 6, // Extend to touch borders
                    height: 809, // Match SVG viewBox height
                    child: CustomPaint(
                      painter: BackgroundShapePainter(),
                    ),
                  ),
                ),
              ),
            
            // Scrollable content
            SingleChildScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    
    // Scale factors to fit the current canvas size
    final scaleX = size.width / 375; // Original SVG width
    final scaleY = size.height / 809; // Original SVG height
    
    // Apply scaling transformation
    canvas.save();
    canvas.scale(scaleX, scaleY);
    
    // SVG path coordinates exactly as in Figma (375x809 viewBox)
    path.moveTo(180.79, 2.72294);
    path.lineTo(3.38161, 127.264);
    path.cubicTo(-0.618715, 130.072, -3, 134.653, -3, 139.541);
    path.lineTo(-3, 793.609);
    path.cubicTo(-3, 801.893, 3.71572, 808.609, 12, 808.609);
    path.lineTo(363, 808.609);
    path.cubicTo(371.284, 808.609, 378, 801.893, 378, 793.609);
    path.lineTo(378, 139.446);
    path.cubicTo(378, 134.611, 375.669, 130.073, 371.74, 127.255);
    path.lineTo(198.148, 2.80894);
    path.cubicTo(192.968, -0.904641, 186.007, -0.939128, 180.79, 2.72294);
    path.close();

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}