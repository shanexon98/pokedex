import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/features/pokemon/presentation/providers/favorites_provider.dart';
import 'package:pokemon/features/pokemon/presentation/utils/type_utils.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/type_image_chip.dart';
import 'package:pokemon/features/pokemon/presentation/pages/pokemon_detail_page.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    super.key,
    required this.id,
    required this.name,
    required this.spriteUrl,
    required this.types,
  });

  final int id;
  final String name;
  final String spriteUrl;
  final List<String> types;

  String _capitalize(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    final primaryType = types.isNotEmpty ? types.first : 'normal';
    final bg = typeColor(primaryType);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => PokemonDetailPage(id: id)),
      ),
      child: Container(
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: bg.withOpacity(0.35),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'N°${id.toString().padLeft(3, '0')}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _capitalize(name),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: types
                          .map((t) => TypeImageChip(assetPath: typeAsset(t)))
                          .toList(growable: false),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 140,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 140,
                      height: 120,
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: 0.5,
                      child: ShaderMask(
                        blendMode: BlendMode.dstIn,
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white,
                              Colors.white,
                              Colors.transparent,
                            ],
                            stops: [0.0, 0.3, 1.0],
                          ).createShader(bounds);
                        },
                        child: Image.asset(
                          typePropertyAsset(primaryType),
                          width: 140,
                          height: 100,
                          color: Colors.white,
                          colorBlendMode: BlendMode.srcATop,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 88,
                            height: 88,
                            decoration: BoxDecoration(
                              color: bg,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: 'sprite_#${id}',
                      child: Image.network(
                        spriteUrl,
                        width: 76,
                        height: 76,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.catching_pokemon, size: 72, color: Colors.black45),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Consumer(
                      builder: (context, ref, _) {
                        final favorites = ref.watch(favoritesProvider);
                        final isFav = favorites.contains(id);
                        return _FavoriteButton(
                          isFav: isFav,
                          onToggle: () => ref.read(favoritesProvider.notifier).toggle(id),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatefulWidget {
  const _FavoriteButton({super.key, required this.isFav, required this.onToggle});
  final bool isFav;
  final VoidCallback onToggle;

  @override
  State<_FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<_FavoriteButton> {
  double _scale = 1.0;

  Future<void> _animateTap() async {
    setState(() => _scale = 1.25);
    await Future.delayed(const Duration(milliseconds: 160));
    if (!mounted) return;
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell
    (
      onTap: () {
        _animateTap();
        widget.onToggle();
      },
      borderRadius: BorderRadius.circular(18),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutBack,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.black38,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            switchInCurve: Curves.easeOutBack,
            switchOutCurve: Curves.easeInBack,
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: Icon(
              widget.isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              key: ValueKey<bool>(widget.isFav),
              color: widget.isFav ? const Color(0xFFE53935) : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}