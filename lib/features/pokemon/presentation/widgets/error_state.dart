import 'package:flutter/material.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/app_button.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    this.title = 'Algo salió mal...',
    this.description =
        'No pudimos cargar la información en este momento.\nVerifica tu conexión o intenta nuevamente más tarde.',
    this.assetPath = 'assets/images/noresults.png',
    this.onRetry,
    this.showRetry = true,
  });

  final String title;
  final String description;
  final String assetPath;
  final VoidCallback? onRetry;
  final bool showRetry;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                assetPath,
                width: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF222222),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),
            if (showRetry)
              AppButton(
                label: 'Reintentar',
                onPressed: onRetry ?? () {},
              ),
          ],
        ),
      ),
    );
  }
}