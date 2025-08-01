import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NoNetworkBottomSheet extends StatelessWidget {
  final VoidCallback? onRetry;

  const NoNetworkBottomSheet({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(5.w), topRight: Radius.circular(5.w)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('assets/lottie/nonetwork.json', width: 50.w, height: 20.h),
          SizedBox(height: 2.h),
          IconButton(
            icon: Icon(Icons.refresh, size: 23.sp),
            onPressed: () {
              Navigator.of(context).pop(); // sheet'i kapat
              onRetry?.call(); // retry çağrısı
            },
          ),
          const Text("İnternet bağlantınızı kontrol ediniz", style: TextStyle(), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
