import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scurry/scurry_page.dart';
import 'package:scurry/scurry_qr_card.dart';

class ScurryCard extends StatefulWidget {
  late String id;
  late String name;
  File? pic;
  ScurryCard({super.key, required this.id, required this.name, this.pic});

  @override
  State<ScurryCard> createState() => ScurryCardState();
}

class ScurryCardState extends State<ScurryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScurryQrCard(name: widget.name)));
        showModalBottomSheet(
            context: context,
            builder: (context) => ScurryQrCard(name: widget.name)
        );
      },
        onForcePressPeak: (ForcePressDetails details) {
          showModalBottomSheet(
              context: context,
              builder: (context) => ScurryQrCard(name: widget.name)
          );
        },
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScurryPage(id: widget.id)));
        },
        child: Card(
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
            ])));
  }
}
