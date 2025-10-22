import 'package:flutter/material.dart';

class PokeballLoader extends StatefulWidget {
  const PokeballLoader({super.key, this.size = 80, this.amplitude = 20, this.opacity = 1.0});

  final double size;
  final double amplitude;
  final double opacity;

  @override
  State<PokeballLoader> createState() => _PokeballLoaderState();
}

class _PokeballLoaderState extends State<PokeballLoader> with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _rotationController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat();

    _bounceAnimation = CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut);
    _rotationAnimation = CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_bounceAnimation, _rotationAnimation]),
      builder: (context, child) {
        return Opacity(
          opacity: widget.opacity,
          child: Transform.translate(
            offset: Offset(0, -widget.amplitude * _bounceAnimation.value),
            child: Transform.rotate(
              angle: _rotationAnimation.value * 2 * 3.1415926535,
              child: Image.asset(
                'assets/images/pokeball.png',
                width: widget.size,
                height: widget.size,
              ),
            ),
          ),
        );
      },
    );
  }
}