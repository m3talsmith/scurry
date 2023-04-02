import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageFormField extends StatefulWidget {
  final Function onSelectImage;
  const ImageFormField(this.onSelectImage, {super.key});

  @override
  State<ImageFormField> createState() => ImageFormFieldState();
}

class ImageFormFieldState extends State<ImageFormField> {
  File? currentImage;

  Future<void> takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera);
    if (imageFile == null) {
      return;
    }
    setState(() {
      currentImage = File(imageFile.path);
    });

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);
    final savedImage = await currentImage!.copy('${appDir.path}/$fileName');

    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: currentImage != null
              ? Image.file(
                  currentImage!,
                  fit: BoxFit.cover,
                )
              : const Text(
                  'No Image',
                  textAlign: TextAlign.center,
                ),
        ),
        IconButton(
                onPressed: takePicture,
                icon: const Icon(Icons.camera))
      ],
    );
  }
}
