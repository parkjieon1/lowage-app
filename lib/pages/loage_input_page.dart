import 'package:flutter/material.dart';
import '../services/loage_api.dart';

class LoAgeInputPage extends StatefulWidget {
  const LoAgeInputPage({super.key});

  @override
  State<LoAgeInputPage> createState() => _LoAgeInputPageState();
}

class _LoAgeInputPageState extends State<LoAgeInputPage> {
  String _gender = 'M';
  final _sitUpsCtrl = TextEditingController();
  final _flexCtrl = TextEditingController();
  final _jumpCtrl = TextEditingController();
  final _recoveryHrCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final result = await LoAgeApi.instance.computeLoAge(
        gender: _gender,
        sitUps: int.tryParse(_sitUpsCtrl.text) ?? 0,
        flexibility: double.tryParse(_flexCtrl.text) ?? 0,
        jumpPower: double.tryParse(_jumpCtrl.text) ?? 0,
        recoveryHr: int.tryParse(_recoveryHrCtrl.text) ?? 0,
      );

      if (mounted) {
        // 입력 > 결과 화면
        Navigator.pushReplacementNamed(
          context,
          '/loage_result',
          arguments: result,
        );
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void dispose() {
    _sitUpsCtrl.dispose();
    _flexCtrl.dispose();
    _jumpCtrl.dispose();
    _recoveryHrCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('체력 정보')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: const InputDecoration(labelText: '성별'),
                  items: const [
                    DropdownMenuItem(
                      value: 'M',
                      child: Text('남성'),
                    ),
                    DropdownMenuItem(
                      value: 'F',
                      child: Text('여성'),
                    ),
                  ],
                  onChanged: (v) {
                    setState(() {
                      _gender = v ?? 'M';
                    });
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _sitUpsCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '윗몸 일으키기 (회)',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _flexCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '앉아서 허리 굽히기 (cm)',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _jumpCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '제자리 뛰기 (cm)',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _recoveryHrCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '운동 후 1분 회복 심박수 (bpm)',
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _submit,
                    child: _loading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('제출하기'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
