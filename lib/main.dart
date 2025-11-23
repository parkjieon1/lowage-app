import 'package:flutter/material.dart';
import 'pages/landing_page.dart';
import 'pages/signup_page.dart';
import 'pages/login_page.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/signup': (context) => const SignupPage(),
        '/login': (context) => const LoginPage(),
        '/input_loage': (context) => const LoageInputPage(),
        '/loage_result': (context) => const LoageResultPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/mission_map': (context) => const MissionMapPage(),
        '/crew_battle': (context) => const CrewBattlePage(),
      },
    );
  }
}
