import 'package:app/views/enter%20screen/register_screen.dart';
import 'package:app/views/main%20screen/main_screen.dart';
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
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => const AuthScreen(),
        '/register': (context) => const RegisterScreen(),
        '/main': (context) => const MainScreen(),
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



