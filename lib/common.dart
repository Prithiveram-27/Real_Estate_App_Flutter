// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class Common {
  static Future<String> convertImageTobase64(String imgFile) async {
    File imagefile = File(imgFile); //convert Path to File
    Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
    String base64string = base64.encode(imagebytes);
    return base64string;
  }
}
