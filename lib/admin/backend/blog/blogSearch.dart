// File: blog_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class BlogService {
  String searchQuery = '';

  Stream<QuerySnapshot> getBlogPosts() {
    if (searchQuery.isEmpty) {
      return FirebaseFirestore.instance.collection('blogPosts').snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('blogPosts')
          .orderBy('title')
          .startAt([searchQuery]).endAt([searchQuery + '\uf8ff']).snapshots();
    }
  }
}
