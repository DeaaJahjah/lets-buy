import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FileService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadeimage(
      String name, File image, BuildContext context) async {
    try {
      await storage.ref(name).putFile(image);
      return storage.ref(name).getDownloadURL();
    } on FirebaseException catch (e) {
      print(e.toString());
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return 'error';
    }
  }

  Future<List<String>> uploadeimages(
      List<XFile> files, BuildContext context) async {
    List<String> urls = [];
    try {
      for (int i = 0; i < files.length; i++) {
        File file = File(files[i].path);
        String name = files[i].path;
        await storage.ref(name).putFile(file);
        String url = await storage.ref(name).getDownloadURL();
        urls.add(url);
      }
      return urls;
    } on FirebaseException catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return [];
    }
  }
}
