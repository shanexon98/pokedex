import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(child: Text('Error: $message')),
        ],
      ),
    );
  }
}