import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReportDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> sendReport(String postId, BuildContext context) async {
    try {
      await _db.collection('reports').add({
        'postId': postId,
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'date': DateTime.now().toIso8601String()
      });
      const snackBar = SnackBar(content: Text('Report sent successfully'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      const snackBar = SnackBar(content: Text('Error sending report'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
