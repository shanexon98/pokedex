import 'package:flutter/material.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Center(
              child: Image.asset(
                'assets/images/comicsoon.png',
                width: 240,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '¡Muy pronto $text disponible!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF222222),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Estamos trabajando para traerte esta sección.\nVuelve más adelante para descubrir todas las novedades.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}