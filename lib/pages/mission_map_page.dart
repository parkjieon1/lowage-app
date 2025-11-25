import 'package:flutter/material.dart';
import '../services/loage_api.dart';
import '../widgets/bottom_nav.dart';

class MissionMapPage extends StatefulWidget {
  const MissionMapPage({super.key});

  @override
  State<MissionMapPage> createState() => _MissionMapPageState();
}

class _MissionMapPageState extends State<MissionMapPage> {
  bool _loading = true;
  List<Map<String, dynamic>> _facilities = [];
  Map<String, dynamic>? _selected;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    const dummyLat = 37.0;
    const dummyLng = 127.0;
    final res = await LoAgeApi.instance.fetchFacilities(
      lat: dummyLat,
      lng: dummyLng,
    );
    if (mounted) {
      setState(() {
        _facilities = res;
        _selected = res.isNotEmpty ? res.first : null;
        _loading = false;
      });
    }
  }

  void _startMission() {
    if (_selected == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MissionRoutePage(
          facility: _selected!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이지팟 지도'),
      ),
      // ★ const 제거
      bottomNavigationBar: LoAgeBottomNav(currentIndex: 1),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    height: 220,
                    color: Colors.blue.shade50,
                    alignment: Alignment.center,
                    child: const Text('지도 영역 (Google / Naver Maps)'),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _facilities.length,
                      itemBuilder: (context, index) {
                        final f = _facilities[index];
                        final selected = _selected?['id'] == f['id'];
                        return ListTile(
                          selected: selected,
                          title: Text(f['name'].toString()),
                          subtitle: Text(
                            '${f['mission']}  |  #${f['category']}',
                          ),
                          onTap: () {
                            setState(() {
                              _selected = f;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _selected == null ? null : _startMission,
                        child: const Text('미션 시작 / 경로 안내'),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class MissionRoutePage extends StatefulWidget {
  final Map<String, dynamic> facility;

  const MissionRoutePage({super.key, required this.facility});

  @override
  State<MissionRoutePage> createState() => _MissionRoutePageState();
}

class _MissionRoutePageState extends State<MissionRoutePage> {
  final _reviewCtrl = TextEditingController();
  bool _submitting = false;

  Future<void> _completeMission() async {
    setState(() => _submitting = true);
    try {
      await LoAgeApi.instance.completeMission(
        missionId: widget.facility['id'] as int,
        reviewText: _reviewCtrl.text.trim(),
      );

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/dashboard',
          (route) => false,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  @override
  void dispose() {
    _reviewCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.facility;
    return Scaffold(
      appBar: AppBar(
        title: const Text('미션팟 안내'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                f['name'].toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('${f['mission']}  |  #${f['category']}'),
              const SizedBox(height: 16),
              Container(
                height: 200,
                color: Colors.blueGrey.shade50,
                alignment: Alignment.center,
                child: const Text('경로 안내 (Route View)'),
              ),
              const SizedBox(height: 16),
              const Text(
                '한 줄 리뷰 작성',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _reviewCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: '가벼운 자전거 타기로 심폐지구력 상승',
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitting ? null : _completeMission,
                  child: _submitting
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('미션 완료'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
