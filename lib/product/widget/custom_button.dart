import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  const CustomButton({super.key, this.onPressed, this.title});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 7.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.h)),
        ),
        onPressed: onPressed,
        child: Text(
          title ?? "",
          style: TextStyle(fontSize: 17.sp, color: colorScheme.onPrimary, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
