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
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(10.0),
                color: const Color.fromRGBO(255, 255, 255, 90),
                child: Text(
                  name,
                  textScaleFactor: 2,
                  softWrap: true,
                ))),
        ]));
  }
}
