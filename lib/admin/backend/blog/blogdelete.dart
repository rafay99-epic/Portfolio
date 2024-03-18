import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> deleteBlogPost(String docId) async {
  final DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('blogPosts').doc(docId).get();
  final String imageUrl = doc['thumbnail'];

  final Reference firebaseStorageRef =
      FirebaseStorage.instance.refFromURL(imageUrl);
  await firebaseStorageRef.delete();

  await FirebaseFirestore.instance.collection('blogPosts').doc(docId).delete();
}
