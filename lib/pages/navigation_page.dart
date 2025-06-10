import 'package:flutter/material.dart';
import 'package:weather/pages/auto_weather.dart';
import 'package:weather/pages/search_weather.dart';
import 'package:weather/pages/landing_page.dart';
import 'package:weather/utilities/bot_navbar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selected = 0;
  void navigate(int index) {
    setState(() {
      _selected = index;
    });
  }

  final List<Widget> _pages = [AutoWeather(), SearchPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      bottomNavigationBar: BotNavbar(
        onTabChange: (index) => navigate(index),
      ),
      body: _pages[_selected],
    );
  }
}
