import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditGenreView extends StatefulWidget {
  const EditGenreView({super.key});

  @override
  State<EditGenreView> createState() => _EditGenreViewState();
}

class _EditGenreViewState extends State<EditGenreView> {
  final genres = [
    'Action',
    'Adventure',
    'Drama',
    'Comedy',
    'Crime',
    'Fantasy',
    'Horror',
    'Sci-fi',
  ];

  List<String> selectedGenres = [];

  @override
  void initState() {
    super.initState();
    loadUserGenres();
  }

  Future<void> loadUserGenres() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    setState(() {
      selectedGenres = List<String>.from(doc['genres'] ?? []);
    });
  }

  Future<void> saveGenres() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'genres': selectedGenres,
    });

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Edit Genres")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: genres.map((g) {
                    final isSelected = selectedGenres.contains(g);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedGenres.remove(g);
                          } else {
                            selectedGenres.add(g);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.redAccent : Colors.white12,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          g,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveGenres,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Save", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
