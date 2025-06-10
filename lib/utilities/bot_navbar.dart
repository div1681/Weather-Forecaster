import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BotNavbar extends StatelessWidget {
  void Function(int)? onTabChange;
  BotNavbar({required this.onTabChange, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: GNav(
          color: Colors.grey[300],
          activeColor: Color(0xFFF2DE9B),
          tabActiveBorder: Border.all(color: Colors.grey[700]!),
          mainAxisAlignment: MainAxisAlignment.center,
          tabBorderRadius: 24,
          onTabChange: (value) => onTabChange!(value),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'HOME',
            ),
            GButton(
              icon: Icons.search,
              text: 'SEARCH',
            ),
          ]),
    );
  }
}
