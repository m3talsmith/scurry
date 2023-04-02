import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scurry/image_form_field.dart';
import 'package:scurry/scurry.dart';

class NewScurryPage extends StatefulWidget {
  @override
  State<NewScurryPage> createState() => NewScurryPageState();
}

class NewScurryPageState extends State<NewScurryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name;
  File? pic;

  updateValidatedAndPop(String name) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(Scurry(name: name));
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
                onFieldSubmitted: (String? value) {
                  updateValidatedAndPop(value!);
                },
              ),
              ImageFormField((image) {}, ),
              ElevatedButton(
                  onPressed: () {
                    updateValidatedAndPop(name!);
                  },
                  child: const Text('Create')
              )
            ],
          )
      ),
    );
  }
}