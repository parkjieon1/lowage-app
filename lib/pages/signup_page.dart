import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _pwConfirmController = TextEditingController();
  bool _agreed = false;

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _pwController.dispose();
    _pwConfirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    if (!_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('약관에 동의해주세요.')),
      );
      return;
    }

    // TODO: 실제 회원가입 API 연동
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nicknameController,
                decoration: const InputDecoration(labelText: '닉네임'),
                validator: (val) =>
                    (val == null || val.isEmpty) ? '닉네임을 입력해주세요.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: '이메일'),
                validator: (val) =>
                    (val == null || val.isEmpty) ? '이메일을 입력해주세요.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pwController,
                obscureText: true,
                decoration: const InputDecoration(labelText: '비밀번호'),
                validator: (val) =>
                    (val == null || val.length < 6) ? '6자 이상 입력해주세요.' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pwConfirmController,
                obscureText: true,
                decoration: const InputDecoration(labelText: '비밀번호 확인'),
                validator: (val) =>
                    (val != _pwController.text) ? '비밀번호가 일치하지 않습니다.' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agreed,
                    onChanged: (v) {
                      setState(() => _agreed = v ?? false);
                    },
                  ),
                  const Expanded(
                    child: Text('이용 약관 및 개인정보 처리방침에 동의합니다.'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _submit,
                  child: const Text('회원가입 완료'),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('이미 계정이 있으신가요? 로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
