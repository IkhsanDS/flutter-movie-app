import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapps/app/modules/profile/profil_view.dart';
import 'package:movieapps/app/modules/search/search_view.dart';
import '../home_controller.dart';

class HomeHeader extends StatelessWidget {
  final HomeController controller;
  const HomeHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hey, ${controller.username.value}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.location.value,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ],
            ),
            Row(
              children: [
                _IconCircle(
                  Icons.search,
                  onTap: () {
                    Get.to(() => const SearchView());
                  },
                ),
                const SizedBox(width: 12),
                _IconCircle(
                  Icons.person,
                  onTap: () {
                    Get.to(() => const ProfileView());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _IconCircle(this.icon, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: CircleAvatar(
        backgroundColor: Colors.white10,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
