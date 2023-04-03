import 'dart:io';

import 'package:flutter/material.dart';

class ScurryPage extends StatelessWidget {
  late String name;
  File? pic;
  ScurryPage({required this.name, this.pic});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Image.file(pic!, fit: BoxFit.fitWidth),
      Center(child: Text(name, textScaleFactor: 2, softWrap: true,)),
    ];

    return Stack(
      children: children,
    );
  }
}