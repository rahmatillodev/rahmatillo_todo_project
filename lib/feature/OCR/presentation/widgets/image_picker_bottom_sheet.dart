import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/constants/app_colors.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const ImagePickerBottomSheet({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 12.h),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text("New",style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w500,color: AppColors.text)),
          ),
          ListTile(
            leading: Icon(Icons.camera_alt,size: 36.sp,color: AppColors.text,),
            title: Text("Take photo",style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w400,color: AppColors.text)),
            onTap: onCameraTap,
          ),
          ListTile(
            leading:  Icon(Icons.photo_library,size: 36.sp,color: AppColors.text,),
            title:  Text("Choose from gallery",style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w400,color: AppColors.text)),
            onTap: onGalleryTap,
          ),
        ],
      ),
      ),
    );
  }
}
