import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapps/app/modules/home/home_controller.dart';
import 'package:movieapps/app/theme/app_colors.dart';

class HomeBottomNav extends GetView<HomeController> {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _item(Icons.movie, 0),
            _item(Icons.favorite, 1),
            _item(Icons.person, 2),
          ],
        ),
      );
    });
  }

  Widget _item(IconData icon, int index) {
    final isActive = controller.tabIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
