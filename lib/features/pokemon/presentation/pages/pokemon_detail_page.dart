import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/features/pokemon/presentation/providers/pokemon_providers.dart';
import 'package:pokemon/features/pokemon/presentation/utils/type_utils.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/type_image_chip.dart';
import 'package:pokemon/features/pokemon/presentation/providers/favorites_provider.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/pokeball_loader.dart';

class PokemonDetailPage extends ConsumerWidget {
  const PokemonDetailPage({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(pokemonDetailByIdProvider(id));
    final speciesAsync = ref.watch(pokemonSpeciesByIdProvider(id));
    final appBarColor = detailAsync.maybeWhen(
      data: (detail) {
        final primaryType = detail.types.isNotEmpty ? detail.types.first : 'normal';
        return typeColor(primaryType);
      },
      orElse: () => Colors.white,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text('#${id.toString().padLeft(3, '0')}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Consumer(builder: (context, refFav, _) {
            final favorites = refFav.watch(favoritesProvider);
            final isFav = favorites.contains(id);
            return IconButton(
              icon: Icon(
                isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: isFav ? const Color(0xFFE53935) : Colors.white,
              ),
              onPressed: () => refFav.read(favoritesProvider.notifier).toggle(id),
              tooltip: isFav ? 'Quitar de favoritos' : 'Añadir a favoritos',
            );
          }),
          const SizedBox(width: 4),
        ],
        backgroundColor: appBarColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: detailAsync.when(
        loading: () => const Center(child: PokeballLoader(size: 80, amplitude: 20, opacity: 0.95)),
        error: (e, st) => Center(child: Text('No se pudo cargar: $e')),
        data: (detail) {
          final primaryType = detail.types.isNotEmpty ? detail.types.first : 'normal';
          final bgColor = typeColor(primaryType);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox.shrink(),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(300),
                      bottomRight: Radius.circular(300),
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
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
                              width: 220,
                              height: 200,
                              color: Colors.white,
                              colorBlendMode: BlendMode.srcATop,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => const SizedBox(),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: -70,
                        child: SizedBox(
                          width: 210,
                          height: 210,
                          child: Hero(
                            tag: 'sprite_#${id}',
                            child: Image.network(
                              detail.spriteUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.catching_pokemon, size: 128, color: Colors.white70),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 420),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 16 * (1 - value)),
                          child: child!,
                        ),
                      );
                    },
                    child: Text(
                      _capitalize(detail.name),
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 420),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 12 * (1 - value)),
                          child: child!,
                        ),
                      );
                    },
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: detail.types
                          .map((t) => TypeImageChip(assetPath: typeAsset(t)))
                          .toList(),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: speciesAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (e, st) => const SizedBox.shrink(),
                    data: (species) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          species.description.isNotEmpty
                              ? species.description
                              : 'Descripción no disponible.',
                          style: const TextStyle(fontSize: 16, height: 1.5),
                        ),
                        const SizedBox(height: 16),
                        _InfoRow(
                          leftLabel: 'PESO',
                          leftValue: '${(detail.weight / 10).toStringAsFixed(1)} kg',
                          rightLabel: 'ALTURA',
                          rightValue: '${(detail.height / 10).toStringAsFixed(1)} m',
                        ),
                        const SizedBox(height: 12),
                        _InfoRow(
                          leftLabel: 'CATEGORÍA',
                          leftValue: species.genus.isNotEmpty ? species.genus.toUpperCase() : '—',
                          rightLabel: 'HABILIDAD',
                          rightValue: detail.abilities.isNotEmpty
                              ? _capitalize(detail.abilities.first)
                              : '—',
                        ),
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                          child: Text('Debilidades',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _weaknesses(detail.types)
                                .map((t) => TypeImageChip(assetPath: typeAsset(t)))
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _capitalize(String s) => s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : s;

List<String> _weaknesses(List<String> types) {
  const map = {
    'normal': ['fighting'],
    'fire': ['water', 'ground', 'rock'],
    'water': ['electric', 'grass'],
    'electric': ['ground'],
    'grass': ['fire', 'ice', 'poison', 'flying', 'bug'],
    'ice': ['fire', 'fighting', 'rock', 'steel'],
    'fighting': ['flying', 'psychic', 'fairy'],
    'poison': ['ground', 'psychic'],
    'ground': ['water', 'grass', 'ice'],
    'flying': ['electric', 'ice', 'rock'],
    'psychic': ['bug', 'ghost', 'dark'],
    'bug': ['fire', 'flying', 'rock'],
    'rock': ['water', 'grass', 'fighting', 'ground', 'steel'],
    'ghost': ['ghost', 'dark'],
    'dragon': ['ice', 'dragon', 'fairy'],
    'dark': ['fighting', 'bug', 'fairy'],
    'steel': ['fire', 'fighting', 'ground'],
    'fairy': ['poison', 'steel'],
  };
  final s = <String>{};
  for (final t in types) {
    final lower = t.toLowerCase();
    final w = map[lower];
    if (w != null) s.addAll(w);
  }
  return s.toList();
}
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.leftLabel,
    required this.leftValue,
    required this.rightLabel,
    required this.rightValue,
  });

  final String leftLabel;
  final String leftValue;
  final String rightLabel;
  final String rightValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _LabeledValue(label: leftLabel, value: leftValue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _LabeledValue(label: rightLabel, value: rightValue),
          ),
        ],
      ),
    );
  }
}

class _LabeledValue extends StatelessWidget {
  const _LabeledValue({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _GenderBar extends StatelessWidget {
  const _GenderBar({required this.malePercent, required this.femalePercent});
  final double malePercent;
  final double femalePercent;

  @override
  Widget build(BuildContext context) {
    final malePct = malePercent.clamp(0, 100) / 100.0;
    final femalePct = femalePercent.clamp(0, 100) / 100.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _GenderBarSegment(label: 'Macho', color: Colors.blue, percentage: malePct),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _GenderBarSegment(label: 'Hembra', color: Colors.pink, percentage: femalePct),
          ),
        ],
      ),
    );
  }
}

class _GenderBarSegment extends StatelessWidget {
  const _GenderBarSegment({required this.label, required this.color, required this.percentage});
  final String label;
  final Color color;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 12,
            backgroundColor: Colors.black12,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _StatsChart extends StatelessWidget {
  const _StatsChart({required this.stats});
  final Map<String, int> stats;

  @override
  Widget build(BuildContext context) {
    const labels = ['HP', 'Ataque', 'Defensa', 'Especial', 'Velocidad'];
    final values = labels.map((l) => stats[l.toLowerCase()] ?? 0).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < labels.length; i++) ...[
            Text(labels[i], style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: (values[i] / 255).clamp(0.0, 1.0),
                minHeight: 12,
                backgroundColor: Colors.black12,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}