import 'package:flutter/material.dart';

class LoageResultPage extends StatelessWidget {
  const LoageResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final label = args?['label'] as String? ?? '측정값 없음';
    final weakness = args?['weakness'] as String? ?? '-';
    final summary = args?['scoreSummary'] as String? ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('신체나이 진단서')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이번 측정 결과',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('신체나이'),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    const Text('주요 취약점'),
                    const SizedBox(height: 8),
                    Text(
                      weakness,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.redAccent),
                    ),
                    if (summary.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(summary),
                    ],
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/dashboard', (route) => false);
                },
                child: const Text('확인'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
