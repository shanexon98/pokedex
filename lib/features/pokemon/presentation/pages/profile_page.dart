import 'package:flutter/material.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/coming_soon_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: ComingSoonWidget(text: 'mi perfil'),
    );
  }
}