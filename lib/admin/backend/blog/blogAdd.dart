import 'dart:html' as html;
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
  required html.File imageFile,
}) async {
  final String fileName = 'blogImage_${DateTime.now().millisecondsSinceEpoch}';
  final Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('blogImages/$fileName');

  final UploadTask uploadTask = firebaseStorageRef.putBlob(imageFile);
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
