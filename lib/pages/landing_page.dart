import 'package:flutter/material.dart';
import 'package:weather/pages/navigation_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Text(
                "W E A T H E R\nF O R E C A S T E R",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Agency",
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFF2DE9B),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavigationPage(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFF1E1E1E),
                    border: Border.all(color: Colors.grey[800]!),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Check Weather",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Orbitron',
                        color: Colors.grey[200],
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 3),
              Text(
                "Made by Divyansh",
                style: const TextStyle(
                  fontFamily: "Agency",
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFFF2DE9B),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
