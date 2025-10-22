import 'package:flutter/material.dart';
import 'package:pokemon/features/pokemon/presentation/pages/pokemon_list_page.dart';
import 'package:pokemon/features/pokemon/presentation/pages/regions_page.dart';
import 'package:pokemon/features/pokemon/presentation/pages/favorites_page.dart';
import 'package:pokemon/features/pokemon/presentation/pages/profile_page.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/app_bottom_nav.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1; // Start at Regiones to match screenshot highlight
  int _previousIndex = 1;

  final List<Widget> _pages = [
    const PokemonListPage(),
    const RegionsPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool slideFromLeft = _currentIndex < _previousIndex;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 450),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        layoutBuilder: (currentChild, previousChildren) => Stack(
          alignment: Alignment.center,
          children: <Widget>[...previousChildren, if (currentChild != null) currentChild],
        ),
        transitionBuilder: (child, animation) {
          final offsetAnimation = Tween<Offset>(
            begin: Offset(slideFromLeft ? -0.08 : 0.08, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

          final fadeAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);

          return FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(position: offsetAnimation, child: child),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_currentIndex),
          child: _pages[_currentIndex],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onChanged: (i) => setState(() {
          _previousIndex = _currentIndex;
          _currentIndex = i;
        }),
      ),
    );
  }
}