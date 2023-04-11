import 'package:flutter/material.dart';
import 'package:scurry/new_scurry_page.dart';
import 'package:scurry/scurry.dart';
import 'package:scurry/scurry_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Scurry> scurries = [];

  Widget listScurries() {
    return ListView(
      children: scurries
          .map((e) => ScurryCard(
                id: e.id!,
                name: e.name!,
                pic: e.pic,
              ))
          .toList(),
      // children: scurries.map((e) => Text(e.name!)).toList(),
    );
  }

  Future<List<Scurry>> findAllScurries() async {
    return Scurry.findAll();
  }

  Future<Widget> getScurries() async {
    scurries = await findAllScurries();
    return listScurries();
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.qr_code_scanner_rounded))
        ],
      ),
      body: FutureBuilder<Widget>(
          future: getScurries(),
          builder: (context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            } else {
              return const CircularProgressIndicator();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Scurry? newScurry = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NewScurryPage()));
          if (newScurry != null) {
            List<Scurry> newScurries = await findAllScurries();
            setState(() {
              scurries = newScurries;
            });
          }
        },
        child: const Icon(Icons.pets_rounded),
      ),
    );
  }
}
