import 'package:flutter/material.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/coming_soon_widget.dart';

class RegionsPage extends StatelessWidget {
  const RegionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const SizedBox.expand(
        child: ComingSoonWidget(text: 'regiones'),
      ),
    );
  }
}