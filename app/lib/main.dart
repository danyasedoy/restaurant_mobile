import 'package:app/views/enter%20screen/register_screen.dart';
import 'package:flutter/material.dart';

import 'views/enter screen/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      initialRoute: '/auth', // The initial screen to display
      routes: {
        '/auth': (context) => const AuthScreen(), // Route for Screen1
        '/register': (context) => const RegisterScreen(), // Route for Screen2
      },
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
          onSurface: Colors.deepOrangeAccent
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}



