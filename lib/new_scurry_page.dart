import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scurry/scurry.dart';

class NewScurryPage extends StatefulWidget {
  @override
  State<NewScurryPage> createState() => NewScurryPageState();
}

class NewScurryPageState extends State<NewScurryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name;
  Image? pic;

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
                decoration: const InputDecoration(
                  hintText: 'Name'
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  name = value;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.of(context).pop(Scurry(name: name));
                    }
                  },
                  child: const Text('Create')
              )
            ],
          )
      ),
    );
    // const Center(
    //   child: Text('New Scurry'),
    // );
  }
}