import 'package:flutter/material.dart';
import 'package:lowage_app/widgets/bottom_nav.dart';   // ★ 이 줄 추가
import '../services/loage_api.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _loading = true;
  Map<String, dynamic>? _data;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final res = await LoAgeApi.instance.fetchDashboard();
    if (mounted) {
      setState(() {
        _data = res;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final nickname = _data?['nickname'] ?? '';
    final loAgeLabel = _data?['lo_age_label'] ?? '';
    final missionsDone = _data?['missions_done'] ?? 0;
    final wins = _data?['wins'] ?? 0;
    final losses = _data?['losses'] ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
      ),
      // ★ const 제거
      bottomNavigationBar: LoAgeBottomNav(currentIndex: 0),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _load,
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    Text(
                      '$nickname 님의 신체나이',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      loAgeLabel,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text('누적 미션'),
                                const SizedBox(height: 4),
                                Text(
                                  '$missionsDone회',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('승'),
                                const SizedBox(height: 4),
                                Text(
                                  '$wins',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('패'),
                                const SizedBox(height: 4),
                                Text(
                                  '$losses',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '이지팟 시작',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/mission_map');
                      },
                      icon: const Icon(Icons.map),
                      label: const Text('내 주변 이지팟 찾기'),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '마이 페이지',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('프로필 수정/확인'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.history),
                      title: const Text('미션 리뷰 히스토리'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.refresh),
                      title: const Text('신체나이 재측정'),
                      onTap: () {
                        Navigator.pushNamed(context, '/loage_input');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.groups),
                      title: const Text('신체나이 동갑 배틀'),
                      onTap: () {
                        Navigator.pushNamed(context, '/crew_battle');
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
