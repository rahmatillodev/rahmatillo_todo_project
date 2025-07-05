import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/core/extensions/extensions.dart';
import 'package:todo/feature/auth/data/auth_service.dart';

class ConfirmLogoutModal extends StatelessWidget {
  const ConfirmLogoutModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Container(
        width: context.screenWidth * 0.8,
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Log out",
              style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w700),
            ),
            16.verticalSpace,
            Text(
              "Are you sure you want to log out?",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
              ),
            ),
            24.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 42.h,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        "No",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                8.horizontalSpace,
                Expanded(
                  child: SizedBox(
                    height: 42.h,
                    child: ElevatedButton(
                      onPressed: () {
                        AuthService.logout();
                        context.go('/');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        "Log out",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
