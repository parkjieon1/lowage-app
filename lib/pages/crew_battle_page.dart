import 'package:flutter/material.dart';
import 'package:lowage_app/widgets/bottom_nav.dart';   // ★
import '../services/loage_api.dart';

class CrewBattlePage extends StatefulWidget {
  const CrewBattlePage({super.key});

  @override
  State<CrewBattlePage> createState() => _CrewBattlePageState();
}

class _CrewBattlePageState extends State<CrewBattlePage> {
  bool _loading = true;
  Map<String, dynamic>? _data;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final res = await LoAgeApi.instance.fetchCrewBattle();
    if (mounted) {
      setState(() {
        _data = res;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final myCrew = _data?['myCrew'] ?? '';
    final opponentCrew = _data?['opponentCrew'] ?? '';
    final myScore = _data?['myScore'] ?? 0;
    final opponentScore = _data?['opponentScore'] ?? 0;
    final status = _data?['status'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('신체나이 동갑 배틀'),
      ),
      // ★ const 제거
      bottomNavigationBar: LoAgeBottomNav(currentIndex: 2),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _load,
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              myCrew,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'VS',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              opponentCrew,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    const Text('우리 크루'),
                                    const SizedBox(height: 4),
                                    Text(
                                      '$myScore',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('상대 크루'),
                                    const SizedBox(height: 4),
                                    Text(
                                      '$opponentScore',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      status,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '이번 주 배틀 설명',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '한 주 동안 동갑 크루끼리 누적 미션 횟수로 승부를 겨룹니다. '
                      '친구의 대시보드를 방문해서 응원 한마디를 남겨보세요.',
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
