import 'package:flutter/material.dart';

import 'package:weather/pages/landing_page.dart';
import 'package:weather/utilities/location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocationService.initPermission();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textSelectionTheme:
              TextSelectionThemeData(selectionHandleColor: Color(0xFFF2DE9B))),
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
