import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/core/constants/app_images.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32.w,32.h,32.w,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("WELCOME TO",style: TextStyle(color: AppColors.text,fontWeight: FontWeight.w300,fontSize: 18.sp)),
          Text("HaBIT Note",style: TextStyle(color: AppColors.text,fontWeight: FontWeight.w400,fontSize: 18.sp,    fontFamily: 'Fugazone',)),
          28.verticalSpace,
          SvgPicture.asset(AppImages.onboarding1,width: 340.w,height: 340.h),
          Text("Take Notes",style: TextStyle(color: AppColors.text,fontSize: 24.sp,fontWeight: FontWeight.w500),),
          Text("Quickly capture what’s on your mind",style: TextStyle(color: AppColors.text,fontSize: 18.sp,fontWeight: FontWeight.w400),),
        ],
      ),
    );
  }
}
