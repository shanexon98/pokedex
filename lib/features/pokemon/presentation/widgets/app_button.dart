import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
    this.height = 56,
    this.borderRadius = 28,
    this.gradient,
    this.textColor = Colors.white,
    this.isLoading = false,
    this.enabled = true,
  });

  final String label;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final double borderRadius;
  final Gradient? gradient;
  final Color textColor;
  final bool isLoading;
  final bool enabled;

  Gradient get _defaultGradient => const LinearGradient(
        colors: [Color(0xFF2D9CFF), Color(0xFF1363DF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  @override
  Widget build(BuildContext context) {
    final Gradient bgGradient = gradient ?? _defaultGradient;

    return Opacity(
      opacity: enabled ? 1 : 0.6,
      child: SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: enabled && !isLoading ? onPressed : null,
            child: Ink(
              decoration: BoxDecoration(
                gradient: bgGradient,
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    offset: Offset(0, 6),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Center(
                child: isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        label,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}