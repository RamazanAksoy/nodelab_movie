import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SocialIconButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;

  const SocialIconButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final onBackgroundColor = Theme.of(context).colorScheme.onBackground;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 6.h,
        width: 6.h,
        decoration: BoxDecoration(
          color: onBackgroundColor.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: onBackgroundColor.withOpacity(0.24)),
        ),
        child: Icon(icon, color: onBackgroundColor, size: 2.5.h),
      ),
    );
  }
}
