import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/features/pokemon/presentation/providers/pokemon_providers.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/app_button.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/delete_button.dart';

void openTypeFilterModal(BuildContext context, WidgetRef ref) {
  final types = const [
    {'label': 'Agua', 'key': 'water'},
    {'label': 'Dragón', 'key': 'dragon'},
    {'label': 'Eléctrico', 'key': 'electric'},
    {'label': 'Hada', 'key': 'fairy'},
    {'label': 'Fantasma', 'key': 'ghost'},
    {'label': 'Fuego', 'key': 'fire'},
    {'label': 'Hielo', 'key': 'ice'},
    {'label': 'Lucha', 'key': 'fighting'},
    {'label': 'Normal', 'key': 'normal'},
    {'label': 'Planta', 'key': 'grass'},
    {'label': 'Psíquico', 'key': 'psychic'},
    {'label': 'Roca', 'key': 'rock'},
    {'label': 'Siniestro', 'key': 'dark'},
    {'label': 'Tierra', 'key': 'ground'},
    {'label': 'Veneno', 'key': 'poison'},
    {'label': 'Volador', 'key': 'flying'},
    {'label': 'Acero', 'key': 'steel'},
  ];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      return Consumer(builder: (context, refModal, _) {
        final selected = refModal.watch(selectedTypesProvider);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Filtra por tus preferencias',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Tipo', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: types.length,
                    itemBuilder: (context, index) {
                      final t = types[index];
                      final label = t['label']!;
                      final key = t['key']!;
                      final checked = selected.contains(key);
                      return ListTile(
                        title: Text(label),
                        trailing: Checkbox(
                          value: checked,
                          onChanged: (_) => refModal.read(selectedTypesProvider.notifier).toggle(key),
                          activeColor: const Color(0xFF0C4AA6),
                          checkColor: Colors.white,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onTap: () => refModal.read(selectedTypesProvider.notifier).toggle(key),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Aplicar',
                        onPressed: () => Navigator.pop(context),
                        height: 52,
                        
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DeleteButton(
                        label: 'Cancelar',
                        onPressed: () {
                          refModal.read(selectedTypesProvider.notifier).clear();
                          Navigator.pop(context);
                        },
                        height: 52,
                       
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}