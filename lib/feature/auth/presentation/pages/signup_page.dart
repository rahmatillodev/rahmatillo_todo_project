import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/feature/auth/data/auth_service.dart';
import 'package:todo/core/widgets/custom_text_field.dart';
import 'package:todo/feature/auth/presentation/widgets/custom_auth_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmController = TextEditingController();

  String? nameError, emailError, passError, confirmError;
  bool isPasswordVisible = false;
  bool isLoading = false;

  bool get isFormValid =>
      nameController.text.trim().length >= 3 &&
      RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(emailController.text) &&
      passController.text.length >= 6 &&
      confirmController.text == passController.text;

  void _onSubmit() async {
    setState(() {
      nameError = nameController.text.trim().length < 3
          ? "Please enter your display name"
          : null;
      emailError =
          !RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(emailController.text.trim())
          ? "Please enter your email"
          : null;
      passError = passController.text.length < 6
          ? "Require at least 6 characters"
          : null;
      confirmError = confirmController.text != passController.text
          ? "Password does not match"
          : null;
    });

    if (isFormValid) {
      final success = await AuthService().signup(
        nameController.text.trim(),
        emailController.text.trim(),
        passController.text,
      );

      if (success) {
        context.go('/home');
      } else {
        setState(() {
          emailError = "Email already exists";
        });
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmController.dispose();
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
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          'Create Account',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Let's get to know you !",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            Text(
              "Enter your details to continue",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
            ),
            24.verticalSpace,
            CustomTextField(
              hintText: "Display Name",
              icon: Icons.person_outlined,
              controller: nameController,
              errorText: nameError,
            ),
            12.verticalSpace,
            CustomTextField(
              hintText: "Email Address",
              icon: Icons.email,
              controller: emailController,
              errorText: emailError,
            ),
            12.verticalSpace,
            CustomTextField(
              hintText: "Password",
              icon: Icons.lock,
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
            12.verticalSpace,
            CustomTextField(
              hintText: "Confirm Password",
              controller: confirmController,
              obscureText: true,
              errorText: confirmError,
            ),
            SizedBox(height: 16.h),
            Text(
              "Already have an account?",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(0, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                context.push('/login');
              },
              child: Text(
                "Login here",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: 36.h),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  const TextSpan(
                    text:
                        'By clicking the "CREATE ACCOUNT" button, you agree to ',
                  ),
                  TextSpan(
                    text: 'Terms of use',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            CustomAuthButton(
              text: 'CREATE ACCOUNT',
              onPressed: _onSubmit,
              isOutlined: false,
              isDisabled: !isFormValid,
            ),
          ],
        ),
      ),
    );
  }
}
