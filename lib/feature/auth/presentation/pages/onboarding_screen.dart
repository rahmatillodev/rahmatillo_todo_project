import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/feature/auth/presentation/pages/onboarding_page1.dart';
import 'package:todo/feature/auth/presentation/pages/onboarding_page2.dart';
import 'package:todo/feature/auth/presentation/pages/onboarding_page3.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = const [
    OnboardingPage1(),
    OnboardingPage2(),
    OnboardingPage3(),
  ];

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: Drawer(
        width: 325.w,
        // backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1479, 1.0],
              colors: [
                const Color.fromRGBO(241, 241, 241, 0.5),
                const Color(0xFFFFB347),
              ],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: Icon(Icons.menu,color: AppColors.primary,size: 24.sp,)),
                    Spacer(flex: 1),
                    Padding(
                      padding: EdgeInsets.only(left: 40.w),
                      child: Text(
                        'HaBIT Note',
                        style: TextStyle(color: AppColors.text, fontSize: 24.sp,fontWeight: FontWeight.w400,    fontFamily: 'Fugazone',),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40.w),
                      child: Text(
                        'V1.0.0',
                        style: TextStyle(color: AppColors.text, fontSize: 18.sp,fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 24.h, left: 40.w),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Forgot Password',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                    ListTile(
                      title: Text('Terms of Use', style: TextStyle(fontSize: 18.sp)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Builder(
                  builder: (context) => IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 24.sp,
                      color: AppColors.primary,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (_, index) => _pages[index],
              ),
            ),

            // Page Indicators
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pages.length, (i) {
                  final isActive = i == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: isActive ? 65.w : 35.w,
                    height: 16.h,
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.orange : AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  );
                }),
              ),
            ),
            // Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Column(
                children: [
                  CustomButton(
                    text: 'Create Account',
                    onPressed: () => context.push('/signup'),
                  ),
                  12.verticalSpace,
                  CustomButton(
                    text: 'Log In',
                    isOutlined: true,
                    onPressed: () => context.push('/login'),
                  ),
                ],
              ),
            ),

            36.verticalSpace,
          ],
        ),
      ),
    );
  }
}
