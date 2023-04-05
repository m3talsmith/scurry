import 'dart:io';

import 'package:flutter/material.dart';

class ScurryCard extends StatefulWidget {
  late String name;
  File? pic;
  ScurryCard({super.key, required this.name, this.pic});

  @override
  State<ScurryCard> createState() => ScurryCardState();
}

class ScurryCardState extends State<ScurryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3.0,
        child: Stack(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.file(widget.pic!, fit: BoxFit.fitWidth)),
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(10.0),
                  color: const Color.fromRGBO(255, 255, 255, 90),
                  child: Text(
                    widget.name,
                    textScaleFactor: 2,
                    softWrap: true,
                  ))),
        ]));
  }
}
