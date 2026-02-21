import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> userProfileStream() {
    final uid = user.value?.uid;
    if (uid == null) {
      throw Exception("User not logged in");
    }
    return _db.collection('users').doc(uid).snapshots();
  }

  bool get isLoggedIn => user.value != null;
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      Get.offAllNamed('/homeRr');
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Login Failed',
        e.message ?? 'Unknown error',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _db.collection('users').doc(cred.user!.uid).set({
        'email': email,
        'name': '',
        'phone': '',
        'city': '',
        'genres': [],
        'favorites': [],
      });
    } catch (e) {
      Get.snackbar(
        'Register Error',
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  Future<void> ensureUserDocument() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set({'name': '', 'city': '', 'phone': '', 'genres': []});
    }
  }

  Future<void> saveProfile({
    required String name,
    required String phone,
    required String city,
  }) async {
    final uid = user.value!.uid;

    await _db.collection('users').doc(uid).update({
      'name': name,
      'phone': phone,
      'city': city,
    });
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
