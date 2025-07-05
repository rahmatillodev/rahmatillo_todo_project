import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/feature/auth/data/auth_service.dart';
import 'package:todo/core/widgets/custom_text_field.dart';
import 'package:todo/feature/auth/presentation/widgets/custom_auth_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  String? emailError, passError;
  bool isPasswordVisible = false;

  bool get isFormValid =>
      RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(emailController.text.trim()) &&
      passController.text.length >= 6;

  void _onSubmit() async {
    // debugPrint('LOGIN button clicked');
    setState(() {
      emailError =
          !RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(emailController.text.trim())
          ? "Please enter your email"
          : null;

      passError = passController.text.length < 6
          ? "Require at least 6 characters"
          : null;
    });

    if (isFormValid) {
      final success = await AuthService().login(
        emailController.text.trim(),
        passController.text,
      );

      if (success) {
        AuthService.isLoggedIn = true;
        context.go('/home');
        emailController.text ="";
        passController.text ="";
      } else {
        setState(() {
          emailError = "Invalid credentials";
          passError = " ";
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
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
          'Log In',
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
              "Welcome back!",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            Text(
              "Please login with your credentials",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300),
            ),

            const Spacer(flex: 2),

            CustomTextField(
              hintText: "Email Address",
              icon: Icons.email_outlined,
              controller: emailController,
              errorText: emailError,
            ),
            12.verticalSpace,
            CustomTextField(
              hintText: "Password",
              icon: Icons.lock_outline,
              controller: passController,
              obscureText: !isPasswordVisible,
              showSuffix: true,
              isPasswordVisible: isPasswordVisible,
              onSuffixTap: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              errorText: passError,
            ),
            8.verticalSpace,
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => context.push('/forgot'),
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.text,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),

            const Spacer(flex: 3),

            Text(
              "Don’t have an account yet ?",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(0, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () => context.push('/signup'),
              child: Text(
                "Create an account here",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                ),
              ),
            ),

            const Spacer(flex: 4),

            CustomAuthButton(
              text: "LOGIN",
              onPressed: _onSubmit,
              isOutlined: false,
              isDisabled: !isFormValid,
            ),
            const Spacer(flex: 4),
          ],
        ),
      ),

    );
  }
}
