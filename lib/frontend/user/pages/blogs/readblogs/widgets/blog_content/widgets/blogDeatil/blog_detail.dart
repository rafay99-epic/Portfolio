// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rafay_portfolio/backend/model/BlogModel.dart';
import 'package:rafay_portfolio/constants/screensSize/screentype.dart';
import 'package:rafay_portfolio/constants/widgets/text/textstyle.dart';
import 'package:rafay_portfolio/constants/widgets/ultis/HoverChip.dart';
import 'package:rafay_portfolio/constants/widgets/ultis/SocialMediaIcon.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/readblogs/widgets/blog_content/widgets/render_content/render_content.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/relatedblogpost/releatedblogpost.dart';
import 'package:share_plus/share_plus.dart';

class BlogDetails extends StatelessWidget {
  final BlogPosModel data;
  final ScreenType screenType;

  const BlogDetails({
    super.key,
    required this.data,
    required this.screenType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 15),
        Padding(
          padding: screenType.isMobile
              ? const EdgeInsets.only(left: 15.0, right: 15.0)
              : const EdgeInsets.only(left: 35.0, right: 35.0),
          child: StyledText(
            text: data.title,
            fontSize: screenType.isMobile ? 30.0 : 40.0,
            color: Theme.of(context).colorScheme.primary,
            bold: true,
            fontFamily: 'ABeeZee',
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),

        Padding(
          padding: screenType.isMobile
              ? const EdgeInsets.only(left: 15.0, right: 15.0)
              : const EdgeInsets.only(left: 35.0, right: 35.0),
          child: StyledText(
            text: data.subTitle,
            fontSize: 20,
            color: Theme.of(context).colorScheme.inversePrimary,
            bold: false,
            fontFamily: 'ABeeZee',
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),

        Padding(
          padding: screenType.isMobile
              ? const EdgeInsets.only(left: 20.0, right: 15.0)
              : const EdgeInsets.only(left: 40.0, right: 35.0),
          child: StyledText(
            text: "Date: ${data.date}",
            fontSize: 18,
            color: Theme.of(context).colorScheme.primary,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10),
        if (!kIsWeb)
          Padding(
            padding: screenType.isMobile
                ? const EdgeInsets.only(left: 20.0, right: 15.0)
                : const EdgeInsets.only(left: 40.0, right: 35.0),
            child: StyledText(
              text: "Author: ${data.author}",
              fontSize: 18,
              color: Theme.of(context).colorScheme.primary,
              fontStyle: FontStyle.italic,
            ),
          ),
        const SizedBox(height: 10),
        Padding(
          padding: screenType.isMobile
              ? const EdgeInsets.only(left: 20.0, right: 15.0)
              : const EdgeInsets.only(left: 40.0, right: 35.0),
          child: StyledText(
            text: "Article Url : ${data.url}",
            fontSize: 18,
            color: Theme.of(context).colorScheme.primary,
            fontStyle: FontStyle.italic,
          ),
        ),

        const SizedBox(height: 10),
        Padding(
          padding: screenType.isMobile
              ? const EdgeInsets.only(left: 20.0, right: 15.0)
              : const EdgeInsets.only(left: 40.0, right: 35.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: List<Widget>.generate(
              data.tags.length,
              (int index) {
                return HoverChip(label: data.tags[index]);
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        //-------------------------
        // Share  Current Article
        //-------------------------
        Padding(
          padding: screenType.isMobile
              ? const EdgeInsets.only(left: 20.0, right: 15.0)
              : const EdgeInsets.only(left: 40.0, right: 35.0),
          child: Row(
            children: <Widget>[
              SocialMediaButton(
                icon: FontAwesomeIcons.facebook,
                url:
                    'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent('https://rafay99.com/blog/${data.url}')}',
                color: Theme.of(context).colorScheme.primary,
              ),
              SocialMediaButton(
                icon: FontAwesomeIcons.twitter,
                url:
                    'https://twitter.com/intent/tweet?text=${Uri.encodeComponent('Check out this blog post:')}%20${Uri.encodeComponent('https://rafay99.com/blog/${data.url}')}',
                color: Theme.of(context).colorScheme.primary,
              ),
              SocialMediaButton(
                icon: FontAwesomeIcons.linkedin,
                url:
                    'https://www.linkedin.com/sharing/share-offsite/?url=${Uri.encodeComponent('https://rafay99.com/blog/${data.url}')}',
                color: Theme.of(context).colorScheme.primary,
              ),
              if (screenType.isMobile)
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.shareAlt,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Share.share(
                        'Check out this blog post: https://rafay99.com/blog/${data.url}');
                  },
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // -------------------------------------------------
        // Render Blog Content on the base of Content Type
        // -------------------------------------------------
        Padding(
          padding: screenType.isMobile
              ? const EdgeInsets.only(left: 15.0, right: 15.0)
              : const EdgeInsets.only(left: 35.0, right: 35.0),
          child: renderContent(data.content, context),
        ),
        const SizedBox(height: 20),

        Align(
          alignment: Alignment.center,
          child: StyledText(
            text: "Releated Articles",
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
            fontStyle: FontStyle.normal,
          ),
        ),
        const SizedBox(height: 20),
        const RelatedBlogPosts(),
        const SizedBox(height: 35),
        //User Comments Near Future
      ],
    );
  }
}
