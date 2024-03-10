// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rafay_portfolio/admin/backend/model/BlogModel.dart';

import 'dart:html' as html;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rafay_portfolio/admin/backend/model/BlogModel.dart';

Future<void> addBlogPost({
  required String title,
  required String subTitle,
  required bool isEnabled,
  required List<String> tags,
  required String author,
  required String content,
  required Uint8List imageFile,
}) async {
  final String fileName = 'blogImage_${DateTime.now().millisecondsSinceEpoch}';
  final Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('blogImages/$fileName');

  // final Blob imageBlob = html.Blob([imageFile]);
  final html.Blob imageBlob = html.Blob([imageFile]);
  final UploadTask uploadTask =
      firebaseStorageRef.putBlob(imageBlob); // Change this line
  final TaskSnapshot taskSnapshot = await uploadTask;
  final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

  BlogPosModel blogPost = BlogPosModel(
    title: title,
    subTitle: subTitle,
    isEnabled: isEnabled,
    tags: tags,
    author: author,
    content: content,
    thumbnail: downloadUrl,
    url: '',
  );

  await FirebaseFirestore.instance.collection('blogPosts').add({
    'title': blogPost.title,
    'subTitle': blogPost.subTitle,
    'isEnabled': blogPost.isEnabled,
    'tags': blogPost.tags,
    'author': blogPost.author,
    'content': blogPost.content,
    'thumbnail': blogPost.thumbnail,
  });
}
