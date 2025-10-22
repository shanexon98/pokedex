import 'package:flutter/material.dart';

class TypeImageChip extends StatelessWidget {
  const TypeImageChip({super.key, required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Image.asset(
        assetPath,
        height: 25,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.help_outline, size: 18, color: Colors.black54);
        },
      ),
    );
  }
}