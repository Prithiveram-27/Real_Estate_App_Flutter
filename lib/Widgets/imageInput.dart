// ignore_for_file: file_names, avoid_print, unrelated_type_equality_checks

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common.dart';
import '../constants.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture(String option) async {
    try {
      final image = await ImagePicker().pickImage(
          source:
              option == "Camera" ? ImageSource.camera : ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        _storedImage = imageTemp;
        print("_absoulute path --------------${_storedImage!.absolute}");
      });
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('imgBase64', _storedImage!.path);
      saveImgBase64();
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  saveImgBase64() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('imgBase64', _storedImage!.path);
    getImgBase();
  }

  getImgBase() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('imgBase64');
    print(action);
  }

  Future _buildPopupDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            title: const Text(
              "Please Select",
              style: TextStyle(fontSize: 18.0),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      _takePicture("Camera");
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Camera",
                      style: TextStyle(color: Constants.primaryColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _takePicture("Gallery");
                      Navigator.pop(context);
                    },
                    child: const Text("Gallery",
                        style: TextStyle(color: Constants.primaryColor)),
                  ),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 150,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: (_storedImage != null && _storedImage != "")
              ? Image.file(_storedImage!.absolute)
              : const Center(
                  child: Text(
                    "No Images added",
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
        const SizedBox(
          width: 25,
        ),
        TextButton(
          onPressed: () {
            _buildPopupDialog(context);
          },
          style: const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(Constants.primaryColor)),
          child: const Text(
            "Add Image",
            style: TextStyle(color: Constants.secondaryColor),
          ),
        ),
      ],
    );
  }
}
