import 'package:flutter/material.dart';
import 'package:scurry/scurry/pages/birth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton.icon(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const BirthPage()));
          },
          icon: const Icon(Icons.baby_changing_station_rounded),
          label: const Text('New Scurry'),
        ),
      ),
    );
  }
}
