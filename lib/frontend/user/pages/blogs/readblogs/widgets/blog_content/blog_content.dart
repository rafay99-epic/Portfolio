// ----------------------------
// build Blogs Content
// ----------------------------

// ignore_for_file: depend_on_referenced_packages, library_prefixes, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:rafay_portfolio/frontend/user/pages/blogs/readblogs/widgets/blog_content/widgets/blogImage/blog_image.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/readblogs/widgets/blog_content/widgets/blogDeatil/blog_detail.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/readblogs/widgets/blog_content/widgets/blogTableOfContent/blog_author_table_of_content.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/readblogs/widgets/blog_content/widgets/extract_heading/extractheading.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'package:rafay_portfolio/backend/model/BlogModel.dart';
import 'package:rafay_portfolio/constants/screensSize/screentype.dart';
import 'package:rafay_portfolio/constants/scrollAnimation/scrollAnimation.dart';

Widget buildBlogContent(
  BuildContext context,
  BlogPosModel data,
  ScrollController scrollController,
  AutoScrollController autoScrollController,
) {
  ScreenType screenType = ScreenType(MediaQuery.of(context).size.width);

  List<Map<String, dynamic>> tableOfContents = extractHeadings(data.content);

  return SingleChildScrollView(
    physics: const CustomScrollPhysics(),
    controller: scrollController,
    child: Column(
      children: [
        BlogImage(data: data),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: BlogDetails(data: data, screenType: screenType),
            ),
            if (screenType.isDesktop)
              Expanded(
                flex: 1,
                child: MediaQuery.of(context).size.width > 600
                    ? BlogAuthorAndContents(
                        data: data,
                        autoScrollController: autoScrollController,
                        tableOfContents: tableOfContents,
                      )
                    : Container(),
              ),
            const SizedBox(height: 25),
          ],
        ),
      ],
    ),
  );
}
