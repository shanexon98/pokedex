import 'package:flutter/material.dart';
import 'package:pokemon/features/pokemon/presentation/pages/main_page.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/app_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = const [
    _OnboardingData(
      imagePath: 'assets/images/onboarding1.png',
      title: 'Todos los Pokémon en\nun solo lugar',
      description:
          'Accede a una amplia lista de Pokémon de\n' 'todas las generaciones creadas por\nNintendo',
      buttonLabel: 'Continuar',
    ),
    _OnboardingData(
      imagePath: 'assets/images/onboarding2.png',
      title: 'Mantén tu Pokédex\nactualizada',
      description:
          'Regístrate y guarda tu perfil, Pokémon\n' 'favoritos, configuraciones y mucho más en la\n' 'aplicación',
      buttonLabel: 'Empecemos',
    ),
  ];

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  void _onButtonPressed() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const MainPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  final data = _pages[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 12),
                        Expanded(
                          child: Image.asset(
                            data.imagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          data.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF222222),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          data.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _PageIndicator(
                          count: _pages.length,
                          currentIndex: _currentPage,
                        ),
                        const SizedBox(height: 24),
                        AppButton(
                          label: data.buttonLabel,
                          onPressed: _onButtonPressed,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingData {
  const _OnboardingData({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.buttonLabel,
  });

  final String imagePath;
  final String title;
  final String description;
  final String buttonLabel;
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    required this.count,
    required this.currentIndex,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 18 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF2D9CFF) : const Color(0xFFD1D5DB),
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}