import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteBlogPost(String docId) async {
  await FirebaseFirestore.instance.collection('blogPosts').doc(docId).delete();
}
