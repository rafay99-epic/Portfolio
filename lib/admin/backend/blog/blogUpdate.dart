import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rafay_portfolio/admin/backend/model/Blog.dart';

Future<void> updateBlogPost(String docId, BlogPosModel blogPost) async {
  await FirebaseFirestore.instance.collection('blogPosts').doc(docId).update({
    'title': blogPost.title,
    'subTitle': blogPost.subTitle,
    'thumbnail': blogPost.thumbnail,
    'url': blogPost.url,
    'isEnabled': blogPost.isEnabled,
    'tags': blogPost.tags,
    'author': blogPost.author,
    'content': blogPost.content,
  });
}
