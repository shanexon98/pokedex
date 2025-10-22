import 'package:flutter/material.dart';

Color typeColor(String type) {
  switch (type.toLowerCase()) {
    case 'grass':
      return const Color(0xFF63BB5B);
    case 'poison':
      return const Color(0xFFB567CE);
    case 'fire':
      return const Color(0xFFFF9D4D);
    case 'water':
      return const Color(0xFF4D90D5);
    case 'bug':
      return const Color(0xFF8FC12C);
    case 'normal':
      return const Color(0xFF9099A1);
    case 'electric':
      return const Color(0xFFF4D23C);
    case 'ground':
      return const Color(0xFFD97746);
    case 'fairy':
      return const Color(0xFFE69EAC);
    case 'fighting':
      return const Color(0xFFCE3E6A);
    case 'psychic':
      return const Color(0xFFF97176);
    case 'rock':
      return const Color(0xFFC7B78B);
    case 'ghost':
      return const Color(0xFF5269AC);
    case 'ice':
      return const Color(0xFF74CEC0);
    case 'dragon':
      return const Color(0xFF0A6DC4);
    case 'dark':
      return const Color(0xFF5A5366);
    case 'steel':
      return const Color(0xFF5A8EA2);
    case 'flying':
      return const Color(0xFF8AAAD6);
    default:
      return const Color(0xFF7A7E83);
  }
}

String typeAsset(String type) {
  switch (type.toLowerCase()) {
    case 'grass':
      return 'assets/images/Type=Planta.png';
    case 'poison':
      return 'assets/images/Type=Veneno.png';
    case 'fire':
      return 'assets/images/Type=Fuego.png';
    case 'water':
      return 'assets/images/Type=Agua.png';
    case 'bug':
      return 'assets/images/Type=Bicho.png';
    case 'normal':
      return 'assets/images/Type=Normal.png';
    case 'electric':
      return 'assets/images/Type=Electrico.png';
    case 'ground':
      return 'assets/images/Type=Tierra.png';
    case 'fairy':
      return 'assets/images/Type=Hada.png';
    case 'fighting':
      return 'assets/images/Type=Lucha.png';
    case 'psychic':
      return 'assets/images/Type=Psíquico.png';
    case 'rock':
      return 'assets/images/Type=Roca.png';
    case 'ghost':
      return 'assets/images/Type=Fantasma.png';
    case 'ice':
      return 'assets/images/Type=Hielo.png';
    case 'dragon':
      return 'assets/images/Type=Dragon.png';
    case 'dark':
      return 'assets/images/Type=Siniestro.png';
    case 'steel':
      return 'assets/images/Type=Acero.png';
    case 'flying':
      return 'assets/images/Type=Volador.png';
    default:
      return 'assets/images/Type=Desconocido.png';
  }
}

String typePropertyAsset(String type) {
  final t = type.toLowerCase();
  const supported = {
    'bug', 'dark', 'dragon', 'electric', 'fairy', 'fighting', 'fire', 'flying',
    'ghost', 'grass', 'ground', 'ice', 'normal', 'poison', 'psychic', 'rock',
    'steel', 'water'
  };
  if (supported.contains(t)) {
    return 'assets/images/Property 1=$t.png';
  }
  return 'assets/images/pokeball.png';
}