// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rafay_portfolio/constants/screensSize/screentype.dart';
import 'package:rafay_portfolio/constants/scrollAnimation/button_scroll.dart';

import 'package:rafay_portfolio/frontend/user/pages/blogs/displayblogs/widgets/blog_display_cards/blog_display_cards.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/readblogs/read_blog.dart';

class BlogLayoutBuilder extends StatelessWidget with ScrollControllerMixin {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final ScreenType screenType;
  final Function setState;
  String searchQuery;

  BlogLayoutBuilder({
    super.key,
    required this.snapshot,
    required this.screenType,
    required this.setState,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        int crossAxisCount;
        if (constraints.maxWidth < 600) {
          crossAxisCount = 1;
        } else if (constraints.maxWidth < 900) {
          crossAxisCount = 2;
        } else if (constraints.maxWidth < 1200) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 4;
        }

        return BlogGridView(
          crossAxisCount: crossAxisCount,
          snapshot: snapshot,
          screenType: screenType,
          setState: setState,
          searchQuery: searchQuery,
        );
      },
    );
  }
}

class BlogGridView extends StatelessWidget with ScrollControllerMixin {
  final int crossAxisCount;
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final ScreenType screenType;
  final Function setState;
  String searchQuery;

  BlogGridView({
    super.key,
    required this.crossAxisCount,
    required this.snapshot,
    required this.screenType,
    required this.setState,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1 / 1,
      ),
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        var doc = snapshot.data!.docs[index];
        return GestureDetector(
          onTap: () {
            if (screenType.isMobile) {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: ReadMeBlogs(
                    id: doc.id,
                  ),
                ),
              ).then(
                (_) {
                  setState(() {
                    searchQuery = '';
                  });
                },
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReadMeBlogs(
                    id: doc.id,
                  ),
                ),
              ).then(
                (_) {
                  setState(() {
                    searchQuery = '';
                  });
                },
              );
            }
          },
          child: BlogCard(doc: doc),
        );
      },
    );
  }
}
