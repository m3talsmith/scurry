import 'package:flutter/material.dart';

import 'common/pages/home.dart';

void main() async {
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
        primaryColor: Colors.lime,
      ),
      home: const HomePage(title: 'Scurry Home'),
    );
  }
}
