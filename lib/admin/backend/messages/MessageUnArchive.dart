import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> unhideMessage(String docId) async {
  await FirebaseFirestore.instance.collection('messages').doc(docId).update({
    'hideMessage': false,
  });
}
