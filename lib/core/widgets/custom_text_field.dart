import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final bool obscureText;
  final String? errorText;
  final TextEditingController controller;
  final VoidCallback? onSuffixTap;
  final bool showSuffix;
  final bool isPasswordVisible;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.icon,
    this.obscureText = false,
    this.errorText,
    this.onSuffixTap,
    this.showSuffix = false,
    this.isPasswordVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 52.h,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(fontSize: 16.sp),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: icon != null
                  ? Icon(icon, color: AppColors.primary, size: 20.sp)
                  : SizedBox(width: 20.w),
              suffixIcon: showSuffix
                  ? GestureDetector(
                onTap: onSuffixTap,
                child: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.grey,
                  size: 20.sp,
                ),
              )
                  : null,
              hintText: hasError ? errorText : hintText,
              hintStyle: TextStyle(
                color: hasError ? AppColors.error : Colors.grey,
                fontSize: 16.sp,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: hasError ? AppColors.error : Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: hasError ? AppColors.error : AppColors.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
