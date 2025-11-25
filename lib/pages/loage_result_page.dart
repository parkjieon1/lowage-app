import 'package:flutter/material.dart';

class LoAgeResultPage extends StatelessWidget {
  const LoAgeResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final loAgeLabel = args?['lo_age_label']?.toString() ?? '알 수 없음';
    final percentile = args?['percentile']?.toString() ?? '-';
    final weakPoint = args?['weak_point']?.toString() ?? '없음';

    return Scaffold(
      appBar: AppBar(title: const Text('신체나이 진단서')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '신체나이',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        loAgeLabel,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('상위 퍼센타일: $percentile%'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber, color: Colors.orange),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text('취약점: $weakPoint'),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // 결과 확인 후: 결과 화면 > 홈화면
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                  child: const Text('확인'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
