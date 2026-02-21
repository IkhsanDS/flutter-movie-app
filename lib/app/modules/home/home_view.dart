import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapps/app/modules/favorite/watchlist_view.dart';
import 'package:movieapps/app/modules/home/home_controller.dart';
import 'package:movieapps/app/modules/home/home_page.dart';
import 'package:movieapps/app/modules/home/widgets/bottom_nav.dart';
import 'package:movieapps/app/modules/profile/profil_view.dart';
import 'package:movieapps/app/theme/app_colors.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        return IndexedStack(
          index: controller.tabIndex.value,
          children: const [
            HomePage(),
            WatchlistView(),
            ProfileView(),
          ],
        );
      }),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
  
  
}
