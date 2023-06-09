import 'package:flutter/material.dart';
import 'package:scurry/server.dart';

import 'home_page.dart';

void main() async {
  try {
    await Server().serve(null);
  } catch (_) {}

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scurry',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.lime,
      ),
      home: const HomePage(title: 'Scurry Home'),
    );
  }
}
