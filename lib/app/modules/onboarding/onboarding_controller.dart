import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  final pageIndex = 0.obs;
  final selectedGenres = <String>[].obs;

  final _db = FirebaseFirestore.instance;

  void toggleGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      selectedGenres.remove(genre);
    } else {
      selectedGenres.add(genre);
    }
  }

  Future<void> saveGenresToFirebase() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await _db.collection('users').doc(uid).update({
      'genres': selectedGenres,
    });
  }

  void next() async {
    if (pageIndex.value == 0) {
      pageIndex.value = 1;
      return;
    }

    if (selectedGenres.isEmpty) {
      Get.snackbar("Oops", "Please select at least one genre");
      return;
    }

    await saveGenresToFirebase();
    Get.offAllNamed(Routes.home);
  }
}