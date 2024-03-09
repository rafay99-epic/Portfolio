import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> hideMessage(String docId) async {
  await FirebaseFirestore.instance.collection('messages').doc(docId).update({
    'hideMessage': true,
  });
}
