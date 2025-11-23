import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class MissionMapPage extends StatelessWidget {
  const MissionMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyMissions = [
      '보라매공원 1km 걷기',
      '실외운동기구 3종 1세트',
      '근처 체육관 러닝머신 20분',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('미션 지도')),
      bottomNavigationBar: const LoAgeBottomNav(currentIndex: 1),
      body: Column(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: const Text('지도 영역 (추후 실제 지도/반경 구현)'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '추천 미션',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dummyMissions.length,
              itemBuilder: (context, index) {
                final m = dummyMissions[index];
                return ListTile(
                  title: Text(m),
                  subtitle: const Text('예상 소요 20~30분'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('\'$m\' 선택 (임시 동작)')),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
