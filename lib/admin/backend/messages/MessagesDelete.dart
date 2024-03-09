// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteMessage(String docId) async {
  await FirebaseFirestore.instance.collection('messages').doc(docId).delete();
}
