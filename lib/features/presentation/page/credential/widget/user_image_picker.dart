import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/widgets.dart';
class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage)imagePickFn;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  UserImagePicker(this.imagePickFn);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery
    );
    if(pickedImageFile == null){
      toast('Please pick an image', Colors.red);
      return;
    }
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickFn(File(pickedImageFile.path));
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 24,
        backgroundColor: const Color.fromRGBO(242, 239, 240, 1),
        backgroundImage: _pickedImage != null ? FileImage(_pickedImage!) : null,
        child: _pickedImage == null ? const Icon(                                
          CupertinoIcons.person_add_solid,
          size: 32,
          color: Colors.black,
        ) : null,
      ),
    );
  }
}