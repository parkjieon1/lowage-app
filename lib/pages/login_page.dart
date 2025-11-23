import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  bool _autoLogin = false;

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  void _login() {
    // TODO: 실제 로그인 API 연동
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: '이메일'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _pwController,
              obscureText: true,
              decoration: const InputDecoration(labelText: '비밀번호'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: _autoLogin,
                  onChanged: (v) => setState(() => _autoLogin = v ?? false),
                ),
                const Text('자동 로그인'),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _login,
                child: const Text('시작하기'),
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: 계정 찾기 화면
              },
              child: const Text('계정을 잊으셨나요?'),
            ),
          ],
        ),
      ),
    );
  }
}
