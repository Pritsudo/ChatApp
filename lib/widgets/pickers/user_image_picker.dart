import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    print('This is Pressed');
    final i = ImagePicker();
    final pickerImage =
        await i.pickImage(source: ImageSource.camera, maxWidth: 600);

    setState(() {
      _pickedImage = File(pickerImage!.path);
    });

    // final picker = ImagePicker();
    // if (pickerImage == null) return;
    // final userImage = File(pickerImage.path);
    // setState(() {
    //   _pickedImage = userImage;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
