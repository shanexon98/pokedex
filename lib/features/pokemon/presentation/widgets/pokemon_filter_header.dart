import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/features/pokemon/presentation/providers/pokemon_providers.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/type_filter_modal.dart';

class PokemonFilterHeader extends ConsumerWidget {
  const PokemonFilterHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
              decoration: InputDecoration(
                hintText: 'Procurar Pokémon...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(color: Colors.black12, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(color: Colors.black12, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(color: Colors.black26, width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () => openTypeFilterModal(context, ref),
            borderRadius: BorderRadius.circular(26),
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black12, width: 2),
              ),
              child: const Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}