import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rafay_portfolio/admin/backend/model/Blog.dart';

Future<void> addBlogPost({
  required String title,
  required String subTitle,
  required bool isEnabled,
  required List<String> tags,
  required String author,
  required String content,
}) async {
  BlogPosModel blogPost = BlogPosModel(
    title: title,
    subTitle: subTitle,
    isEnabled: isEnabled,
    tags: tags,
    author: author,
    content: content,
    thumbnail: '',
    url: '',
  );

  await FirebaseFirestore.instance.collection('blogPosts').add({
    'title': blogPost.title,
    'subTitle': blogPost.subTitle,
    'isEnabled': blogPost.isEnabled,
    'tags': blogPost.tags,
    'author': blogPost.author,
    'content': blogPost.content,
  });
}
