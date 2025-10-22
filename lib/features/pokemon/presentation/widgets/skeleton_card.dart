import 'package:flutter/material.dart';

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}