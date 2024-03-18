// Enabling Blog Post
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> enableBlogPost(String docId) async {
  await FirebaseFirestore.instance.collection('blogPosts').doc(docId).update({
    'isEnabled': true,
  });
}
