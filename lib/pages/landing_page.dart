import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _checking = true;

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
  }

  Future<void> _checkAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final autoLogin = prefs.getBool('autoLogin') ?? false;
    final token = prefs.getString('sessionToken');

    if (autoLogin && token != null && token.isNotEmpty) {
      // 자동 로그인 플로우: 앱 접속 화면 > 홈화면
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      setState(() {
        _checking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checking) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '로에이지로 Low Age\n길에서 쉽게, 신체나이 낮추기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                const Icon(
                  Icons.directions_walk,
                  size: 80,
                  color: Colors.blue,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // 첫 접속 플로우: 앱 접속 화면 > 로그인 화면
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text('시작하기'),
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
