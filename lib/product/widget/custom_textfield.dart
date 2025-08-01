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
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(2.h),
        border: Border.all(color: Colors.white24),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.4.h),
        child: TextField(
          obscureText: isObscure,
          onChanged: onChanged,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white60),
            border: InputBorder.none,
            icon: Icon(icon, color: Colors.white),
            suffixIcon: suffixIcon, // Sadece dışarıdan gelirse göster, yoksa hiç gösterme
          ),
        ),
      ),
    );
  }
}
