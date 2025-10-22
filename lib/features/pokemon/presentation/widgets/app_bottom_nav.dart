import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;

  static const Color _activeColor = Color(0xFF1363DF);
  static const Color _inactiveColor = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, -6),
            blurRadius: 12,
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 12, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavItem(
            icon: Icons.home,
            label: 'Pokedex',
            selected: currentIndex == 0,
            onTap: () => onChanged(0),
          ),
          _NavItem(
            icon: Icons.public,
            label: 'Regiones',
            selected: currentIndex == 1,
            onTap: () => onChanged(1),
          ),
          _NavItem(
            icon: Icons.favorite,
            label: 'favoritos',
            selected: currentIndex == 2,
            onTap: () => onChanged(2),
          ),
          _NavItem(
            icon: Icons.person,
            label: 'Perfil',
            selected: currentIndex == 3,
            onTap: () => onChanged(3),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color active = const Color(0xFF0D6EFD);
    final Color inactive = const Color(0xFF475569);

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutQuad,
                scale: selected ? 1.15 : 1.0,
                child: Icon(
                  icon,
                  color: selected ? active : inactive,
                ),
              ),
              const SizedBox(height: 6),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutQuad,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? active : inactive,
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}