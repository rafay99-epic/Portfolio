// import 'dart:html' as html;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:rafay_portfolio/backend/model/BlogModel.dart';

// class ArticleFunctionality {
//   //Adding Blog Post
//   Future<void> addBlogPost({
//     required String title,
//     required String subTitle,
//     required bool isEnabled,
//     required List<String> tags,
//     required String author,
//     required String content,
//     required html.File imageFile,
//     required DateTime date,
//   }) async {
//     final String fileName =
//         'blogImage_${DateTime.now().millisecondsSinceEpoch}';
//     final Reference firebaseStorageRef =
//         FirebaseStorage.instance.ref().child('blogImages/$fileName');

//     final UploadTask uploadTask = firebaseStorageRef.putBlob(imageFile);

//     // Listen for changes in the upload task's progress
//     final Stream<TaskSnapshot> stream = uploadTask.snapshotEvents;
//     stream.listen((TaskSnapshot snapshot) {
//       print('Task state: ${snapshot.state}');
//       print(
//           'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
//     }, onError: (e) {
//       print(e);
//     });

//     final TaskSnapshot taskSnapshot = await uploadTask;
//     final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

//     BlogPosModel blogPost = BlogPosModel(
//       title: title,
//       subTitle: subTitle,
//       isEnabled: isEnabled,
//       tags: tags,
//       author: author,
//       content: content,
//       thumbnail: downloadUrl,
//       url: '',
//       date: date,
//     );

//     await FirebaseFirestore.instance.collection('blogPosts').add({
//       'title': blogPost.title,
//       'subTitle': blogPost.subTitle,
//       'isEnabled': blogPost.isEnabled,
//       'tags': blogPost.tags,
//       'author': blogPost.author,
//       'content': blogPost.content,
//       'thumbnail': blogPost.thumbnail,
//       'date': date,
//     });

//     print('Upload complete');
//   }

//   // Article Delete
//   Future<void> deleteBlogPost(String docId) async {
//     final DocumentSnapshot doc = await FirebaseFirestore.instance
//         .collection('blogPosts')
//         .doc(docId)
//         .get();
//     final String imageUrl = doc['thumbnail'];

//     final Reference firebaseStorageRef =
//         FirebaseStorage.instance.refFromURL(imageUrl);
//     await firebaseStorageRef.delete();

//     await FirebaseFirestore.instance
//         .collection('blogPosts')
//         .doc(docId)
//         .delete();
//   }

//   // Article Disable
//   Future<void> disableBlogPost(String docId) async {
//     await FirebaseFirestore.instance.collection('blogPosts').doc(docId).update({
//       'isEnabled': false,
//     });
//   }

//   //Article Enable
//   Future<void> enableBlogPost(String docId) async {
//     await FirebaseFirestore.instance.collection('blogPosts').doc(docId).update({
//       'isEnabled': true,
//     });
//   }

//   // Search Articles
//   String searchQuery = '';

//   Stream<QuerySnapshot> getBlogPosts() {
//     if (searchQuery.isEmpty) {
//       return FirebaseFirestore.instance.collection('blogPosts').snapshots();
//     } else {
//       return FirebaseFirestore.instance
//           .collection('blogPosts')
//           .orderBy('title')
//           .startAt([searchQuery]).endAt(['$searchQuery\uf8ff']).snapshots();
//     }
//   }

//   //Update Article

//   Future<void> updateBlogPost({
//     required String id,
//     required String title,
//     required String subTitle,
//     required bool isEnabled,
//     required List<String> tags,
//     required String author,
//     required String content,
//     html.File? imageFile,
//     required DateTime date,
//   }) async {
//     final String fileName =
//         'blogImage_${DateTime.now().millisecondsSinceEpoch}';
//     final Reference firebaseStorageRef =
//         FirebaseStorage.instance.ref().child('blogImages/$fileName');

//     final UploadTask uploadTask = firebaseStorageRef.putBlob(imageFile);

//     // Listen for changes in the upload task's progress
//     final Stream<TaskSnapshot> stream = uploadTask.snapshotEvents;
//     stream.listen((TaskSnapshot snapshot) {
//       print('Task state: ${snapshot.state}');
//       print(
//           'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
//     }, onError: (e) {
//       print(e);
//     });

//     final TaskSnapshot taskSnapshot = await uploadTask;
//     String downloadUrl = await taskSnapshot.ref.getDownloadURL();

//     BlogPosModel blogPost = BlogPosModel(
//       title: title,
//       subTitle: subTitle,
//       isEnabled: isEnabled,
//       tags: tags,
//       author: author,
//       content: content,
//       thumbnail: downloadUrl,
//       url: '',
//       date: date,
//     );

//     await FirebaseFirestore.instance.collection('blogPosts').doc(id).update({
//       'title': blogPost.title,
//       'subTitle': blogPost.subTitle,
//       'isEnabled': blogPost.isEnabled,
//       'tags': blogPost.tags,
//       'author': blogPost.author,
//       'content': blogPost.content,
//       'thumbnail': blogPost.thumbnail,
//       'date': date,
//     });

//     print('Update complete');
//   }
// }

import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rafay_portfolio/backend/model/BlogModel.dart';

class ArticleFunctionality {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addBlogPost({
    required String title,
    required String subTitle,
    required bool isEnabled,
    required List<String> tags,
    required String author,
    required String content,
    required html.File imageFile,
    required DateTime date,
  }) async {
    final String fileName =
        'blogImage_${DateTime.now().millisecondsSinceEpoch}';
    final Reference storageRef = _storage.ref().child('blogImages/$fileName');

    final UploadTask uploadTask = storageRef.putBlob(imageFile);
    await _monitorUpload(uploadTask);

    final String downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();

    BlogPosModel blogPost = BlogPosModel(
      title: title,
      subTitle: subTitle,
      isEnabled: isEnabled,
      tags: tags,
      author: author,
      content: content,
      thumbnail: downloadUrl,
      url: '',
      date: date,
    );

    await _firestore.collection('blogPosts').add(blogPost.toMap());

    print('Upload complete');
  }

  Future<void> _monitorUpload(UploadTask uploadTask) async {
    final Stream<TaskSnapshot> stream = uploadTask.snapshotEvents;
    await for (var snapshot in stream) {
      print('Task state: ${snapshot.state}');
      print(
          'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
    }
  }

  Future<void> deleteBlogPost(String docId) async {
    final DocumentSnapshot doc =
        await _firestore.collection('blogPosts').doc(docId).get();
    final String imageUrl = doc['thumbnail'];

    final Reference storageRef = _storage.refFromURL(imageUrl);
    await storageRef.delete();

    await _firestore.collection('blogPosts').doc(docId).delete();
  }

  Future<void> updateBlogPostStatus(String docId, bool isEnabled) async {
    await _firestore.collection('blogPosts').doc(docId).update({
      'isEnabled': isEnabled,
    });
  }

  String searchQuery = '';
  Stream<QuerySnapshot> getBlogPosts() {
    return searchQuery.isEmpty
        ? _firestore.collection('blogPosts').snapshots()
        : _firestore
            .collection('blogPosts')
            .orderBy('title')
            .startAt([searchQuery]).endAt(['$searchQuery\uf8ff']).snapshots();
  }

  Future<void> updateBlogPost({
    required String id,
    required String title,
    required String subTitle,
    required bool isEnabled,
    required List<String> tags,
    required String author,
    required String content,
    html.File? imageFile,
    required DateTime date,
  }) async {
    final String fileName =
        'blogImage_${DateTime.now().millisecondsSinceEpoch}';
    final Reference storageRef = _storage.ref().child('blogImages/$fileName');

    final UploadTask uploadTask = storageRef.putBlob(imageFile);
    await _monitorUpload(uploadTask);

    final String downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();

    BlogPosModel blogPost = BlogPosModel(
      title: title,
      subTitle: subTitle,
      isEnabled: isEnabled,
      tags: tags,
      author: author,
      content: content,
      thumbnail: downloadUrl,
      url: '',
      date: date,
    );

    await _firestore.collection('blogPosts').doc(id).update(blogPost.toMap());

    print('Update complete');
  }
}
