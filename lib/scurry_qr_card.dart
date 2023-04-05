import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScurryQrCard extends StatelessWidget {
  late String name;
  ScurryQrCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImage(data: name),
    );
    // return ListView(
    //   padding: EdgeInsets.all(10.0),
    //     children: [Text('Hello, $name')]);
  }
}