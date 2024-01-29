import 'package:flutter/material.dart'; 
import 'package:notes_app/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF546E7A),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blueGrey[800],
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/agregar': (context) => NotaScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Material App',
    );
  }
}
