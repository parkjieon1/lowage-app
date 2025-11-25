import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/loage_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  bool _autoLogin = false;
  bool _loading = false;
  String? _error;

  Future<void> _handleLogin() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final token = await LoAgeApi.instance.login(
        email: _emailCtrl.text.trim(),
        password: _pwCtrl.text,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('sessionToken', token);
      await prefs.setBool('autoLogin', _autoLogin);

      // 로그인 후 플로우: 로그인 화면 > 신체나이 입력 화면
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/loage_input');
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
    _emailCtrl.dispose();
    _pwCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  labelText: '이메일',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _pwCtrl,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: _autoLogin,
                    onChanged: (v) {
                      setState(() => _autoLogin = v ?? false);
                    },
                  ),
                  const Text('자동 로그인 동의'),
                ],
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
                  onPressed: _loading ? null : _handleLogin,
                  child: _loading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('시작하기'),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text('회원가입'),
                  ),
                  TextButton(
                    onPressed: () {
                      // 계정 찾기 링크 자리
                    },
                    child: const Text('계정 찾기'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
