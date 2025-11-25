import 'package:flutter/material.dart';
import '../services/loage_api.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nicknameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  final _pwConfirmCtrl = TextEditingController();
  bool _agree = false;
  bool _loading = false;
  String? _error;

  Future<void> _handleSignup() async {
    if (!_agree) {
      setState(() {
        _error = '약관에 동의해주세요.';
      });
      return;
    }
    if (_pwCtrl.text != _pwConfirmCtrl.text) {
      setState(() {
        _error = '비밀번호가 일치하지 않습니다.';
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await LoAgeApi.instance.signup(
        nickname: _nicknameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        password: _pwCtrl.text,
      );

      if (mounted) {
        // 회원가입 후 플로우: 회원가입 화면 > (제출하기) > 로그인 화면
        Navigator.pop(context);
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
    _nicknameCtrl.dispose();
    _emailCtrl.dispose();
    _pwCtrl.dispose();
    _pwConfirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _nicknameCtrl,
                  decoration: const InputDecoration(labelText: '닉네임'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(labelText: '이메일'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _pwCtrl,
                  decoration: const InputDecoration(labelText: '비밀번호'),
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _pwConfirmCtrl,
                  decoration: const InputDecoration(labelText: '비밀번호 확인'),
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: _agree,
                      onChanged: (v) {
                        setState(() => _agree = v ?? false);
                      },
                    ),
                    const Flexible(child: Text('약관 동의')),
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
                    onPressed: _loading ? null : _handleSignup,
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
