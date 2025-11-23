import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class CrewBattlePage extends StatelessWidget {
  const CrewBattlePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyCrews = [
      {'name': '20대 후반 크루', 'score': 18, 'me': true},
      {'name': '30대 초반 크루', 'score': 15, 'me': false},
      {'name': '40대 중반 크루', 'score': 9, 'me': false},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('동갑크루 배틀')),
      bottomNavigationBar: const LoAgeBottomNav(currentIndex: 2),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: dummyCrews.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final c = dummyCrews[index];
          final isMe = c['me'] as bool;
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(c['name'] as String),
              subtitle: Text('이번 주 미션 점수: ${c['score']}'),
              trailing: isMe ? const Text('나') : null,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${c['name']} 상세는 추후 구현 예정입니다.'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
