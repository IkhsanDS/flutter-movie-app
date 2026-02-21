import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapps/app/theme/app_colors.dart';

Widget inputField(
  String hint, {
  ValueChanged<String>? onChanged,
  required TextEditingController controller,
}) {
  return TextField(
    controller: controller, // 🔥 INI KUNCI NYA
    onChanged: onChanged,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.white38,
        fontFamily: 'poppins',
      ),
      filled: true,
      fillColor: Colors.white10,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
  );
}


Widget passwordInput({
  required TextEditingController controller,
}) {
  final isHidden = true.obs;

  return Obx(() {
    return TextField(
      controller: controller,
      obscureText: isHidden.value,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Password',
        filled: true,
        fillColor: Colors.white10,
        suffixIcon: IconButton(
          icon: Icon(
            isHidden.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.white54,
          ),
          onPressed: () {
            isHidden.value = !isHidden.value;
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  });
}


Widget primaryButton(String text, VoidCallback onTap) {
  return SizedBox(
    width: double.infinity,
    height: 56,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'poppins', fontWeight: FontWeight.bold),
      ),
    ),
  );
}
Widget authSeparator() {
  return Row(
    children: const [
      Expanded(child: Divider(color: Colors.white24)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          'or',
          style: TextStyle(color: Colors.white54),
        ),
      ),
      Expanded(child: Divider(color: Colors.white24)),
    ],
  );
}
Widget socialButtons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _socialButton(Icons.facebook),
      _socialButton(Icons.g_mobiledata), // Google
      _socialButton(Icons.apple),
    ],
  );
}
Widget _socialButton(IconData icon) {
  return Expanded(
    child: Container(
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 28,
      ),
    ),
  );
  }
Widget trailerButton(VoidCallback onPressed) {
  return OutlinedButton.icon(
    onPressed: onPressed,
    icon: const Icon(
      Icons.play_arrow,
      color: Colors.white,
    ),
    label: const Text(
      'Trailer',
      style: TextStyle(color: Colors.white),
    ),
  );
}

