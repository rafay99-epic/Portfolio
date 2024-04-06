import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:rafay_portfolio/backend/model/BlogModel.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/relatedblogpost/widgets/author.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/relatedblogpost/widgets/build_styletext.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/relatedblogpost/widgets/social_share.dart';

class RelatedBlogPosts extends StatelessWidget {
  const RelatedBlogPosts({Key? key}) : super(key: key);

  Future<List<BlogPosModel>> getReleatedBlogPost() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('blogPosts').limit(3).get();

    if (querySnapshot.docs.isEmpty) {
      throw Exception('No blog posts found');
    }

    querySnapshot.docs.shuffle();

    return querySnapshot.docs.map((doc) {
      return BlogPosModel.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Widget buildBlogPostCard(BlogPosModel blogPost, BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        width: 500,
        height: 200,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/blog/${blogPost.url}',
            );
          },
          child: Card(
            color: Theme.of(context).colorScheme.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
                width: isMobile ? 1 : 2,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildStyledText(blogPost.title, 18.0, FontWeight.bold,
                      Theme.of(context).colorScheme.primary),
                  const SizedBox(height: 10.0),
                  buildStyledText(
                      DateFormat('yyyy-MM-dd').format(blogPost.date),
                      16.0,
                      FontWeight.w400,
                      Theme.of(context).colorScheme.outline),
                  const SizedBox(height: 10.0),
                  buildAuthorRow(blogPost.author, context),
                  buildSocialMediaRow(blogPost.url, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return FutureBuilder<List<BlogPosModel>>(
      future: getReleatedBlogPost(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: Theme.of(context).colorScheme.inversePrimary,
            backgroundColor: Theme.of(context).colorScheme.background,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(
            child: isMobile
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: snapshot.data!.map((blogPost) {
                      return buildBlogPostCard(blogPost, context);
                    }).toList(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: snapshot.data!.map((blogPost) {
                      return Expanded(
                        child: buildBlogPostCard(blogPost, context),
                      );
                    }).toList(),
                  ),
          );
        }
      },
    );
  }
}
