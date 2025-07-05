import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/core/constants/app_images.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32.w,32.h,32.w,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 1),
          SvgPicture.asset(AppImages.onboarding2,width: 340.w,height: 340.h),
          Text("To-dos",style: TextStyle(color: AppColors.text,fontSize: 24.sp,fontWeight: FontWeight.w500),),
          Text("List out your day-to-day tasks",style: TextStyle(color: AppColors.text,fontSize: 18.sp,fontWeight: FontWeight.w400),),
          12.verticalSpace

        ],
      ),
    );
  }
}
