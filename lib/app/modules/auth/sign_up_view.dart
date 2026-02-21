import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapps/app/modules/auth/auth_controller.dart';
import 'package:movieapps/app/modules/auth/sign_in_view.dart';
import 'package:movieapps/app/modules/auth/sign_up_success_view.dart';
import 'package:movieapps/app/theme/app_colors.dart';
import 'package:movieapps/app/theme/widgets.dart';

class SignUpView extends GetView<AuthController> {
  SignUpView({super.key});

  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true, // 👈 penting
      body: SafeArea(
        child: SingleChildScrollView(
          // 👈 scroll
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              

                const SizedBox(height: 200),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 32),

                inputField('E-mail', controller: emailC),
                const SizedBox(height: 16),
                passwordInput(controller: passwordC),

                const SizedBox(height: 32),

                primaryButton('Sign up', () async {
                  try {
                    await controller.signUp(
                      emailC.text.trim(),
                      passwordC.text.trim(),
                    );

                    Get.offAll(() => const SignUpSuccessView());
                  } catch (e) {
                    Get.snackbar('Error', e.toString());
                  }
                }),

                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'By clicking the “sign up” button, you accept the terms\nof the Privacy Policy',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white54),
                  ),
                ),

                const SizedBox(height: 48), // 👈 ganti Spacer

                Center(
                  child: GestureDetector(
                    onTap: () => Get.to(() => SignInView()),
                    child: const Text(
                      'Already have an account? Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
