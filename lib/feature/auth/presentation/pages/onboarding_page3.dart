import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/core/constants/app_images.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32.w,32.h,32.w,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 1),
          SvgPicture.asset(AppImages.onboarding3,width: 340.w,height: 340.h),
          Text("Image to Text Converter",style: TextStyle(color: AppColors.text,fontSize: 24.sp,fontWeight: FontWeight.w500),),
          Text("Upload your images and convert to text",style: TextStyle(color: AppColors.text,fontSize: 18.sp,fontWeight: FontWeight.w400),),
          12.verticalSpace
        ],
      ),
    );
  }
}
