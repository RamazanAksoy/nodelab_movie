import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isObscure;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;

  const CustomTextField({super.key, required this.hintText, required this.icon, this.isObscure = false, this.onChanged, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant, // Arkaplan koyu ton
        borderRadius: BorderRadius.circular(2.h),
        border: Border.all(color: colorScheme.onSurface.withOpacity(0.24)), // Hafif şeffaf border
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.4.h),
        child: TextField(
          obscureText: isObscure,
          onChanged: onChanged,
          style: TextStyle(color: colorScheme.onSurface), // Yazı rengi
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)), // Hint yazısı
            border: InputBorder.none,
            icon: Icon(icon, color: colorScheme.onSurface), // Icon rengi
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
