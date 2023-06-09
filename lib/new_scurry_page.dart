import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scurry/image_form_field.dart';
import 'package:scurry/scurry.dart';

class NewScurryPage extends StatefulWidget {
  const NewScurryPage({super.key});

  @override
  State<NewScurryPage> createState() => NewScurryPageState();
}

class NewScurryPageState extends State<NewScurryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name;
  File? pic;

  updateValidatedAndPop(String name, File? pic) async {
    if (_formKey.currentState!.validate() && pic != null) {
      _formKey.currentState!.save();
      NavigatorState nav = Navigator.of(context);
      Scurry scurry = await Scurry(name: name, pic: pic).save();
      _formKey.currentState!.reset();
      nav.pop(scurry);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Build a New Scurry'),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(hintText: 'Name'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  name = value;
                },
                onFieldSubmitted: (String? value) {
                  updateValidatedAndPop(value!, pic);
                },
                onChanged: (String? value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              ImageFormField((image) {
                pic = image;
              }),
              ElevatedButton(
                  onPressed: () {
                    if (name != null) {
                      updateValidatedAndPop(name!, pic);
                    }
                  },
                  child: const Text('Create'))
            ],
          )),
    );
  }
}
