import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:movieapps/app/initial_view.dart';
import 'package:movieapps/app/modules/auth/auth_controller.dart';
// import 'package:movieapps/app/modules/favorite/favorite_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(AuthController(), permanent: true);
  // Get.put(HomeController(), permanent: true); // 🔥 TAMBAH INI DULU

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash, // 👈 SATU SAJA
      getPages: AppPages.pages,
    );
  }
}
