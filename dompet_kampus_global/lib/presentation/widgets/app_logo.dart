import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool light;
  final bool withText;

  const AppLogo({super.key, this.size = 56, this.light = false, this.withText = false});

  @override
  Widget build(BuildContext context) {
    Widget icon = Image.asset(
      'assets/images/daqi.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );

    if (!withText) return icon;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(width: 12),
        Text(
          'daqi',
          style: TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: size * 0.46,
            fontWeight: FontWeight.w800,
            color: light ? Colors.white : const Color(0xFF1565C0),
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}
