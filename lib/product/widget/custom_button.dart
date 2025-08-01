import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  const CustomButton({super.key, this.onPressed, this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 7.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFE50914),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.h)),
        ),
        onPressed: onPressed,
        child: Text(
          title ?? "",
          style: TextStyle(fontSize: 17.sp, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
