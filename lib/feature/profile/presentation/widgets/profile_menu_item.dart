import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/core/extensions/extensions.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          width: context.screenWidth * 0.75,
          height: 45.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(icon, color: AppColors.text, size: 24.sp),
              24.horizontalSpace,
              Text(
                label,
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
