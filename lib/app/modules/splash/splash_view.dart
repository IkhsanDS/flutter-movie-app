import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';
import 'package:movieapps/app/theme/app_colors.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: 0.9 + (value * 0.1),
                child: child,
              ),
            );
          },
          child: Image.asset(
            'lib/assets/logo.png', 
            width: 400, 
          ),
        ),
      ),
    );
  }
}