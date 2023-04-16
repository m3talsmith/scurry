import 'package:flutter/material.dart';

class BirthPage extends StatefulWidget {
  const BirthPage({super.key});

  @override
  State<BirthPage> createState() => BirthPageState();
}

class BirthPageState extends State<BirthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name;

  int _index = 0;
  List<Step> get _steps {
    return <Step>[
      Step(
          title: const Text('Name your Scurry'),
          content: Form(
              key: _formKey,
              child: TextFormField(
                decoration: const InputDecoration(hintText: 'Name'),
              ))),
      const Step(
          title: Text('Choose a profile picture'), content: Text('File Step'))
    ];
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
          onStepContinue: () {
            if (_index <= 0) {
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
