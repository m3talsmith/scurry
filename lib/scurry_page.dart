import 'dart:io';

import 'package:flutter/material.dart';

class ScurryPage extends StatelessWidget {
  late String name;
  File? pic;
  ScurryPage({required this.name, this.pic});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3.0,
        child: Stack(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.file(pic!, fit: BoxFit.fitWidth)),
          Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    color: const Color.fromARGB(95, 255, 255, 255),
                    child: Text(
                      name,
                      textScaleFactor: 2,
                      softWrap: true,
                    ))))
        ]));
  }
}
