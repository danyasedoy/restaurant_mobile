import 'package:flutter/material.dart';

import 'views/enter screen/enter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.deepOrange,
          onPrimary: Colors.deepOrangeAccent,
          secondary: Colors.yellow,
          onSecondary: Colors.yellowAccent,
          error: Colors.red,
          onError: Colors.redAccent,
          surface: Colors.black,
          onSurface: Colors.white
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthScreen(),
    );
  }
}



