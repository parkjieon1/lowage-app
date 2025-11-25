import 'package:flutter/material.dart';
import 'pages/landing_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/loage_input_page.dart';
import 'pages/loage_result_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/mission_map_page.dart';
import 'pages/crew_battle_page.dart';

void main() {
  runApp(const LoAgeApp());
}

class LoAgeApp extends StatelessWidget {
  const LoAgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoAge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/loage_input': (context) => const LoAgeInputPage(),
        '/loage_result': (context) => const LoAgeResultPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/mission_map': (context) => const MissionMapPage(),
        '/crew_battle': (context) => const CrewBattlePage(),
      },
    );
  }
}
