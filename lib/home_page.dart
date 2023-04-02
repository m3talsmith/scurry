import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scurry/new_scurry_page.dart';
import 'package:scurry/scurry.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;


  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Scurry> scurries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.qr_code_scanner_rounded))
        ],
      ),
      body: Column(
        children: scurries.map((e) => Text(e.name!)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          Scurry newScurry = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewScurryPage()
            )
          );
          log("newScurry: ${newScurry.name}");
          scurries.add(newScurry);
        },
        child: const Icon(Icons.pets_rounded),
      ),
    );
  }
}