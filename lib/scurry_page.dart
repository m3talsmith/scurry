import 'package:flutter/material.dart';
import 'package:scurry/scurry.dart';

class ScurryPage extends StatefulWidget {
  late String id;
  ScurryPage({super.key, required this.id});

  @override
  ScurryPageState createState() => ScurryPageState();
}

class ScurryPageState extends State<ScurryPage> {
  Scurry? scurry;

  Future<Scurry?> _loadDetails() async {
    scurry = await Scurry.find(widget.id);
    return scurry;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scurry Details'),
      ),
      body: FutureBuilder(
        future: _loadDetails(),
        builder: (BuildContext context, AsyncSnapshot<Scurry?> snapshot) {
          if (snapshot.hasData) {
            scurry = snapshot.data;
            if (scurry == null) {
              return const Text('Scurry not found');
            }
            // return Text('id: ${widget.id}, name: ${scurry!.name}');
            return Card(
            )
          }
          return const Center(
              child: CircularProgressIndicator(
            value: null,
          ));
        }));
  }
}
