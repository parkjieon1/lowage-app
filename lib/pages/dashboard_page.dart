import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 나중에 닉네임/신체나이/통계는 실제 값으로 교체
    const nickname = '공주님';
    const loAgeLabel = '30대 초반 (임시)';
    const missionCount = 5;

    return Scaffold(
      appBar: AppBar(title: const Text('내 대시보드')),
      bottomNavigationBar: const LoAgeBottomNav(currentIndex: 0),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Text(
              '$nickname 님의 LoAge',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('현재 신체나이'),
                    Text(
                      loAgeLabel,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: const Text('누적 미션 수행'),
                subtitle: Text('$missionCount 회 (임시값)'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/input_loage');
                },
                child: const Text('신체나이 다시 측정하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
