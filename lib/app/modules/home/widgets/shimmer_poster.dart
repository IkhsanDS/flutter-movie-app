import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPoster extends StatelessWidget {
  const ShimmerPoster({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
