import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteController extends GetxController {
  final favorites = <int>[].obs;

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final doc = await _db.collection('users').doc(uid).get();

    if (!doc.exists) return;

    favorites.value = List<int>.from(doc.data()?['favorites'] ?? []);
  }

  bool isFavorite(int movieId) {
    return favorites.contains(movieId);
  }

  Future<void> toggleFavorite(Map<String, dynamic> movie) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final movieId = movie['id'];

    if (favorites.contains(movieId)) {
      favorites.remove(movieId);
    } else {
      favorites.add(movieId);
    }

    await _db.collection('users').doc(uid).set({
      'favorites': favorites,
    }, SetOptions(merge: true));
  }

  Future<void> removeFavorite(int movieId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    favorites.remove(movieId);

    await _db.collection('users').doc(uid).set({
      'favorites': favorites,
    }, SetOptions(merge: true));
  }
}
    