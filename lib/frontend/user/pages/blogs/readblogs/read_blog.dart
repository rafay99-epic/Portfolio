// ----------------------------
// ReadMeBlogs Widget
// ----------------------------
// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rafay_portfolio/constants/widgets/errorAndLanding/error.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/readblogs/widgets/blog_content/blog_content.dart';
import 'package:rafay_portfolio/constants/widgets/errorAndLanding/loading.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/readblogs/widgets/appbar/appbar.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:rafay_portfolio/backend/model/BlogModel.dart';

class ReadMeBlogs extends StatefulWidget {
  final String? id;
  final String? url;

  const ReadMeBlogs({
    Key? key,
    this.id,
    this.url,
  }) : super(key: key);

  @override
  _ReadMeBlogsState createState() => _ReadMeBlogsState();
}

class _ReadMeBlogsState extends State<ReadMeBlogs> {
  late ScrollController _scrollController;
  final autoScrollcontroller = AutoScrollController();
  final ValueNotifier<double> _progress = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        _progress.value = _scrollController.offset /
            _scrollController.position.maxScrollExtent;
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<BlogPosModel> getBlogPost({String? url}) async {
    QuerySnapshot querySnapshot;

    if (url != null) {
      querySnapshot = await FirebaseFirestore.instance
          .collection('blogPosts')
          .where('url', isEqualTo: url)
          .get();
    } else {
      querySnapshot = await FirebaseFirestore.instance
          .collection('blogPosts')
          .where(FieldPath.documentId, isEqualTo: widget.id)
          .get();
    }

    if (querySnapshot.docs.isEmpty) {
      throw Exception('Blog post not found');
    }

    DocumentSnapshot doc = querySnapshot.docs.first;
    return BlogPosModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, _progress),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<BlogPosModel>(
        future: getBlogPost(url: widget.url),
        builder: (BuildContext context, AsyncSnapshot<BlogPosModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingIndicator(context);
          } else if (snapshot.hasError) {
            return buildErrorWidget(context);
          } else {
            return buildBlogContent(
              context,
              snapshot.data!,
              _scrollController,
              autoScrollcontroller,
            );
          }
        },
      ),
    );
  }
}
