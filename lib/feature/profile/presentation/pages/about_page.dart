import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/core/constants/app_images.dart';
import 'package:todo/core/extensions/extensions.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.text, size: 24.sp),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            color: AppColors.text,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: context.screenWidth,
            color: AppColors.primary,
            padding: EdgeInsets.symmetric(
              vertical: 15.h,
            ), // istasangiz tashqi joy qoldirish
            alignment: Alignment.center,
            child: Image.asset(
              AppImages.habitNote,
              height: 150.h,
              fit: BoxFit.contain,
            ),
          ),
          32.verticalSpace,
          SizedBox(
            width: context.screenWidth * 0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Application",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "HaBIT Note",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,
          SizedBox(
            width: context.screenWidth * 0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Version",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "V1.0.0",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,
          SizedBox(
            width: context.screenWidth * 0.75,
            child: Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
            ),
          ),
          16.verticalSpace,
          SizedBox(
            width: context.screenWidth * 0.75,
            child: Text(
              "Terms of Use",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
