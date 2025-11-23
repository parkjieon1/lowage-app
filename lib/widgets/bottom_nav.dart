import 'package:flutter/material.dart';

class LoAgeBottomNav extends StatelessWidget {
  final int currentIndex;

  const LoAgeBottomNav({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/mission_map');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/crew_battle');
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
          icon: Icon(Icons.person),
          label: '대시보드',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: '미션',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.groups),
          label: '동갑크루',
        ),
      ],
    );
  }
}
