import 'package:flutter/material.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/app_button.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
    this.height = 56,
    this.borderRadius = 28,
    this.textColor = Colors.white,
    this.isLoading = false,
    this.enabled = true,
  });

  final String label;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final double borderRadius;
  final Color textColor;
  final bool isLoading;
  final bool enabled;

  Gradient get _grayGradient => const LinearGradient(
        colors: [Color(0xFF9CA3AF), Color(0xFF6B7280)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      width: width,
      height: height,
      borderRadius: borderRadius,
      gradient: _grayGradient,
      textColor: textColor,
      isLoading: isLoading,
      enabled: enabled,
    );
  }
}