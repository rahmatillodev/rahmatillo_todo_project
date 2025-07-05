import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/core/widgets/custom_text_field.dart';
import 'package:todo/feature/auth/presentation/widgets/custom_auth_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  String? emailError;
  bool isSent = false;

  bool get isValidEmail =>
      RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(emailController.text.trim());

  void _onSubmit() {
    setState(() {
      if (!isValidEmail) {
        emailError = "Enter a valid email";
        isSent = false;
      } else {
        emailError = null;
        isSent = true;
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Forgot Password',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 36.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please enter your account’s email address and we will send you a link \nto reset your password.",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300),
            ),
            Spacer(flex: 1),
            CustomTextField(
              hintText: "Email",
              icon: Icons.email_outlined,
              controller: emailController,
              errorText: emailError,
            ),
            24.verticalSpace,
            if (isSent)
              Text(
                "Reset link sent to your email",
                style: TextStyle(color: AppColors.primary, fontSize: 14.sp),
              ),
            const Spacer(flex: 4),
            CustomAuthButton(
              text: "SUBMIT",
              onPressed: _onSubmit,
              isOutlined: false,
              isDisabled: emailController.text.trim().isEmpty,
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
