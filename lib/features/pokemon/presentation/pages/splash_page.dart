import 'package:flutter/material.dart';
import 'package:pokemon/features/pokemon/presentation/pages/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _rotationController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    // Controlador para el rebote
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Controlador para la rotación
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );
    
    // Animación de rebote con efecto 
    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.bounceOut,
    ));
    
    // Animación de rotación 
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));
    
    _startAnimations();
  }

  void _startAnimations() async {
    // Iniciar rotación continua
    _rotationController.repeat();
    
    // Rebote inicial
    await _bounceController.forward();
    await _bounceController.reverse();
    
    for (int i = 0; i < 2; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      await _bounceController.forward(from: 0.0);
      await _bounceController.reverse();
    }
    
    // Esperar y pasar al onboarding
    await Future.delayed(const Duration(milliseconds: 1000));
    
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnboardingPage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pokebola animada
            AnimatedBuilder(
              animation: Listenable.merge([_bounceAnimation, _rotationAnimation]),
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -50 * _bounceAnimation.value),
                  child: Transform.rotate(
                    angle: _rotationAnimation.value * 2 * 3.14159,
                    child: Image.asset(
                      'assets/images/pokeball.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 50),
            
            // Texto de carga
            AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: (_bounceAnimation.value).clamp(0.0, 1.0),
                  child: const Text(
                    'PokéDex',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2.0,
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 20),
            
            // Indicador de carga
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: 0.7,
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}