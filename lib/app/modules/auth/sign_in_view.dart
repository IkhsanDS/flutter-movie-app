import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapps/app/modules/auth/auth_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/widgets.dart';
import 'sign_up_view.dart';

class SignInView extends GetView<AuthController> {
  SignInView({super.key});

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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             

              const SizedBox(height: 200),

              const Text(
                'Sign In',
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

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              primaryButton('Sign in', () async {
                try {
                  await controller.login(emailC.text, passwordC.text);
                } catch (e) {
                  Get.snackbar('Login Failed', e.toString());
                  SnackPosition.BOTTOM;
                }
              }),


              const SizedBox(height: 48), // 👈 ganti Spacer

              Center(
                child: GestureDetector(
                  onTap: () => Get.to(() => SignUpView()),
                  child: const Text(
                    'Don’t you have an account? Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
