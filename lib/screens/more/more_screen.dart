import 'package:flutter/material.dart';
import 'widgets/profile_card.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const userName = 'Ajlan';
    const userEmail = 'ajlan@gmail.com';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileCard(
              name: 'Ajlan',
              phone: '+91 98765 43210',
              imageUrl: '',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}