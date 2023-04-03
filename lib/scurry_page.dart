import 'dart:io';

import 'package:flutter/material.dart';

class ScurryPage extends StatelessWidget {
  late String name;
  File? pic;
  ScurryPage({required this.name, this.pic});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [Text(name)];
    children.add((pic != null) ? Image.file(pic!) : const Text('No Image Yet'));
    return Row(
      children: children,
    );
  }
}