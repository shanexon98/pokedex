class PokemonDetail {
  PokemonDetail({
    required this.id,
    required this.name,
    required this.spriteUrl,
    required this.types,
    required this.weight,
    required this.height,
    required this.abilities,
  });

  final int id;
  final String name;
  final String spriteUrl;
  final List<String> types;
  final int weight; // hectograms
  final int height; // decimeters
  final List<String> abilities;

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>?;
    final frontDefault = sprites != null ? sprites['front_default'] as String? : null;
    final typesList = (json['types'] as List<dynamic>? ?? [])
        .map((e) => (e as Map<String, dynamic>)['type'] as Map<String, dynamic>)
        .map((m) => m['name'] as String)
        .toList(growable: false);
    final abilitiesList = (json['abilities'] as List<dynamic>? ?? [])
        .map((e) => (e as Map<String, dynamic>)['ability'] as Map<String, dynamic>)
        .map((m) => m['name'] as String)
        .toList(growable: false);

    return PokemonDetail(
      id: json['id'] as int,
      name: json['name'] as String,
      spriteUrl: frontDefault ?? '',
      types: typesList,
      weight: (json['weight'] as int?) ?? 0,
      height: (json['height'] as int?) ?? 0,
      abilities: abilitiesList,
    );
  }
}