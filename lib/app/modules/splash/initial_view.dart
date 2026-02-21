import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/auth_controller.dart';
import '../auth/sign_in_view.dart';
import '../../routes/app_routes.dart';

class InitialView extends GetView<AuthController> {
  const InitialView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    return Obx(() {
      if (!auth.isLoggedIn) {
        return SignInView();
      }

      // 🔥 cek genre user
      Future.microtask(() async {
        final uid = FirebaseAuth.instance.currentUser!.uid;

        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();

        final genres = List.from(doc.data()?['genres'] ?? []);

        if (genres.isEmpty) {
          Get.offAllNamed(Routes.onboarding);
        } else {
          Get.offAllNamed(Routes.home);
        }
      });

      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    });
  }
}
