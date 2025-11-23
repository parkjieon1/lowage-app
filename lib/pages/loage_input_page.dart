import 'package:flutter/material.dart';

class LoageInputPage extends StatefulWidget {
  const LoageInputPage({super.key});

  @override
  State<LoageInputPage> createState() => _LoageInputPageState();
}

class _LoageInputPageState extends State<LoageInputPage> {
  final _formKey = GlobalKey<FormState>();
  String _sex = 'F';
  final _sitUpsController = TextEditingController();
  final _flexController = TextEditingController();
  final _jumpController = TextEditingController();
  final _cardioController = TextEditingController();

  @override
  void dispose() {
    _sitUpsController.dispose();
    _flexController.dispose();
    _jumpController.dispose();
    _cardioController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;

    // TODO: 여기서 실제 .pkl 모델 API 호출로 교체
    // 지금은 임시로 "30대 초반 / 취약점: 유연성" 하드코딩
    final dummyResult = {
      'label': '30대 초반',
      'weakness': '유연성',
      'scoreSummary': '상체 근지구력, 심폐지구력은 양호 / 유연성이 상대적으로 약함',
    };

    Navigator.pushNamed(
      context,
      '/loage_result',
      arguments: dummyResult,
    );
  }

  Widget _numField(TextEditingController c, String label) {
    return TextFormField(
      controller: c,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      validator: (val) {
        if (val == null || val.isEmpty) return '값을 입력해주세요.';
        if (double.tryParse(val) == null) return '숫자로 입력해주세요.';
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('체력 정보 입력')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _sex,
                decoration: const InputDecoration(labelText: '성별'),
                items: const [
                  DropdownMenuItem(value: 'F', child: Text('여성')),
                  DropdownMenuItem(value: 'M', child: Text('남성')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _sex = val);
                },
              ),
              const SizedBox(height: 12),
              _numField(_sitUpsController, '윗몸일으키기(회)'),
              const SizedBox(height: 12),
              _numField(_flexController, '앉아허리 굽히기(cm)'),
              const SizedBox(height: 12),
              _numField(_jumpController, '제자리 멀리뛰기(cm)'),
              const SizedBox(height: 12),
              _numField(_cardioController, '1분 회복 심박수(bpm)'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _submit,
                  child: const Text('신체나이 진단하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
