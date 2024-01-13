import 'package:flutter/material.dart';
import 'package:start/pages/home.dart';
import 'package:start/theme/color.dart' as colors;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Start',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: colors.backgroundColor,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: colors.backgroundColor,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomePage(),
    );
  }
}
