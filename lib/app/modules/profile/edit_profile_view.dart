import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapps/app/modules/auth/auth_controller.dart';
// import 'package:movieapps/app/theme/widgets.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  Widget _modernInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white54),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    final nameC = TextEditingController();
    final cityC = TextEditingController();
    final phoneC = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 🔥 Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white12,
              child: const Icon(Icons.person, size: 50, color: Colors.white70),
            ),

            const SizedBox(height: 40),

            // 🔥 Name Field
            _modernInput(
              controller: nameC,
              hint: "Name",
              icon: Icons.person_outline,
            ),

            const SizedBox(height: 20),

            // 🔥 City Field
            _modernInput(
              controller: cityC,
              hint: "City",
              icon: Icons.location_on_outlined,
            ),

            const SizedBox(height: 20),

            // 🔥 Phone Field
            _modernInput(
              controller: phoneC,
              hint: "Phone",
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 50),

            // 🔥 Save Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () async {
                  await auth.saveProfile(
                    name: nameC.text.trim(),
                    phone: phoneC.text.trim(),
                    city: cityC.text.trim(),
                  );

                  Get.back();
                },
                child: const Text(
                  "Save Changes",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'poppins', color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
