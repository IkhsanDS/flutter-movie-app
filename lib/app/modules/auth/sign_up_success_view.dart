import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapps/app/routes/app_routes.dart';
import 'package:movieapps/app/theme/app_colors.dart';
import 'package:movieapps/app/theme/widgets.dart';

import 'auth_controller.dart';

class SignUpSuccessView extends StatelessWidget {
  const SignUpSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    final nameC = TextEditingController();
    final phoneC = TextEditingController();
    final cityC = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 96),

              const Text(
                'Complete your profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),
              const Text(
                'Tell us more about you',
                style: TextStyle(color: Colors.white54),
              ),

              const SizedBox(height: 32),

              inputField('Your name', controller: nameC),
              const SizedBox(height: 16),
              inputField('Phone number', controller: phoneC),
              const SizedBox(height: 16),
              inputField('City', controller: cityC),

              const Spacer(),

              primaryButton('Continue', () async {
                if (nameC.text.isEmpty ||
                    phoneC.text.isEmpty ||
                    cityC.text.isEmpty) {
                  Get.snackbar('Error', 'Please complete all fields');
                  return;
                }

                await auth.saveProfile(
                  name: nameC.text.trim(),
                  phone: phoneC.text.trim(),
                  city: cityC.text.trim(),
                );

                // lanjut ke genre preference
               Get.offAllNamed(Routes.onboarding);

              }),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
