import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'onboarding_controller.dart';
import '../../theme/app_colors.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              Align(
                alignment: Alignment.topRight,

              ),

              Expanded(
                child: controller.pageIndex.value == 0
                    ? _posterStep()
                    : _genreStep(),
              ),

              _nextButton(
                onPressed:
                    controller.pageIndex.value == 1 &&
                        controller.selectedGenres.isEmpty
                    ? null
                    : controller.selectedGenres.isEmpty
                    ? null
                    : controller.next,
              ),
              const SizedBox(height: 24),
              _indicator(),
              const SizedBox(height: 32),
            ],
          );
        }),
      ),
    );
  }

  Widget _posterStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.movie, color: Colors.white, size: 120),
        SizedBox(height: 24),
        Text(
          'Tell us about your\nfavorite movie genres',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'poppins',
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Widget _genreStep() {
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: genres.map((g) {
              final isSelected = controller.selectedGenres.contains(g);

              return GestureDetector(
                onTap: () => controller.toggleGenre(g),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.chip,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(g, style: const TextStyle(color: Colors.white)),
                ),
              );
            }).toList(),
          );
        }),
        const SizedBox(height: 40),
        const Text(
          'Select the genres you\nlike to watch',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'poppins',
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Widget _nextButton({VoidCallback? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          onPressed: controller.next,
          child: const Text(
            'Next',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'poppins',
            ),
          ),
        ),
      ),
    );
  }

  Widget _indicator() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(2, (index) {
          final isActive = controller.pageIndex.value == index;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 28 : 8,
            height: 4,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : Colors.white24,
              borderRadius: BorderRadius.circular(999),
            ),
          );
        }),
      );
    });
  }
}