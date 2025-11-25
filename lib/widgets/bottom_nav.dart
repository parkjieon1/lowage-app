// lib/widgets/bottom_nav.dart
import 'package:flutter/material.dart';

class LoAgeBottomNav extends StatelessWidget {
  final int currentIndex;

  const LoAgeBottomNav({
    super.key,
    required this.currentIndex,
  });

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/dashboard',
          (route) => false,
        );
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/mission_map',
          (route) => false,
        );
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/crew_battle',
          (route) => false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (idx) => _onTap(context, idx),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: '이지팟',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.groups),
          label: '또래 배틀',
        ),
      ],
    );
  }
}
