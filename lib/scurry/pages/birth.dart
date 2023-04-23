import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scurry/common/form/image_form_field.dart';
import 'package:scurry/scurry/scurry_model.dart';

class BirthPage extends StatefulWidget {
  const BirthPage({super.key});

  @override
  State<BirthPage> createState() => BirthPageState();
}

class BirthPageState extends State<BirthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name;
  File? pic;

  int _index = 0;
  List<Step> get _steps {
    return <Step>[
      Step(
          title: const Text('Name your Scurry'),
          content: Form(
              key: _formKey,
              child: TextFormField(
                decoration: const InputDecoration(hintText: 'Name'),
                onChanged: (String change) {
                  name = change;
                },
              ))),
      Step(
          title: const Text('Choose a profile picture'),
          content: ImageFormField((image) {
            pic = image;
          }))
    ];
  }

  Future<ScurryModel> createScurry() async {
    ScurryModel scurry = ScurryModel(name: name!, pics: [
      ScurryPic(path: pic!.path)
    ]);

    return scurry;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scurry Born')),
      body: Stepper(
          currentStep: _index,
          steps: _steps,
          onStepCancel: () {
            if (_index > 0) {
              setState(() {
                _index -= 1;
              });
            }
          },
          onStepContinue: () async {
            if (_index <= 0) {
              if (_index == _steps.length - 1) {
                var nav = Navigator.of(context);
                ScurryModel scurry = await createScurry();
                nav.pop(scurry);
                return;
              }
              setState(() {
                _index += 1;
              });
            }
          },
          onStepTapped: (int index) {
            setState(() {
              _index = index;
            });
          }),
    );
  }
}
