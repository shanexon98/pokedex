class PokemonSpecies {
  PokemonSpecies({
    required this.genus,
    required this.description,
    required this.genderRate, // 0..8 where 8 = 100% female
  });

  final String genus;
  final String description;
  final int genderRate;

  double get femalePercent => (genderRate.clamp(0, 8) / 8.0) * 100.0;
  double get malePercent => 100.0 - femalePercent;

  factory PokemonSpecies.fromJson(Map<String, dynamic> json) {
    final genera = (json['genera'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();
    final esGenus = genera.firstWhere(
      (g) => (g['language'] as Map<String, dynamic>)['name'] == 'es',
      orElse: () => genera.isNotEmpty ? genera.first : <String, dynamic>{},
    );
    final genusText = esGenus.isNotEmpty ? (esGenus['genus'] as String? ?? '') : '';

    final flavorTexts = (json['flavor_text_entries'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();
    final esFlavor = flavorTexts.firstWhere(
      (f) => (f['language'] as Map<String, dynamic>)['name'] == 'es',
      orElse: () => flavorTexts.isNotEmpty ? flavorTexts.first : <String, dynamic>{},
    );
    final desc = esFlavor.isNotEmpty ? (esFlavor['flavor_text'] as String? ?? '') : '';

    return PokemonSpecies(
      genus: genusText.replaceAll('\n', ' ').trim(),
      description: desc.replaceAll('\n', ' ').trim(),
      genderRate: (json['gender_rate'] as int?) ?? 0,
    );
  }
}