import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ModernBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    
    // 1. Subtle Radial Gradient for depth
    final mainGradient = RadialGradient(
      center: const Alignment(-0.8, -0.6),
      radius: 1.2,
      colors: [
        AppColors.primary.withOpacity(0.05),
        Colors.transparent,
      ],
    );
    canvas.drawRect(rect, Paint()..shader = mainGradient.createShader(rect));

    // 2. Sophisticated Organic Shapes
    _drawOrganicShape(
      canvas, 
      size, 
      color: AppColors.primary.withOpacity(0.06),
      offset: const Offset(-50, -100),
      radius: size.width * 0.8,
      rotation: 0.2,
    );

    _drawOrganicShape(
      canvas, 
      size, 
      color: AppColors.accent.withOpacity(0.04),
      offset: Offset(size.width * 0.6, size.height * 0.4),
      radius: size.width * 0.7,
      rotation: -0.5,
    );

    // 3. Floating "Glass" Accents
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Top Right accent
    _drawGlassCircle(
      canvas, 
      Offset(size.width * 0.9, size.height * 0.15), 
      60, 
      AppColors.primaryLight.withOpacity(0.03),
    );

    // Middle Left accent
    _drawGlassCircle(
      canvas, 
      Offset(size.width * 0.05, size.height * 0.5), 
      120, 
      AppColors.primaryDark.withOpacity(0.02),
    );

    // Bottom Right accent
    _drawGlassCircle(
      canvas, 
      Offset(size.width * 0.85, size.height * 0.85), 
      100, 
      AppColors.accent.withOpacity(0.03),
    );
  }

  void _drawOrganicShape(Canvas canvas, Size size, {
    required Color color, 
    required Offset offset, 
    required double radius,
    required double rotation,
  }) {
    final paint = Paint()
      ..color = color
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);

    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.rotate(rotation);
    
    final path = Path();
    path.addOval(Rect.fromCenter(center: Offset.zero, width: radius * 1.2, height: radius * 0.8));
    
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawGlassCircle(Canvas canvas, Offset center, double radius, Color color) {
    final paint = Paint()
      ..color = color
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    
    canvas.drawCircle(center, radius, paint);
    
    // Inner subtle ring
    final ringPaint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    canvas.drawCircle(center, radius, ringPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
