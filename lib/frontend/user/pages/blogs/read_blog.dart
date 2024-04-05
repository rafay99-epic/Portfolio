// ignore_for_file: library_private_types_in_public_api, library_prefixes, depend_on_referenced_packages, prefer_adjacent_string_concatenation

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlParser;
import 'package:lottie/lottie.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:rafay_portfolio/backend/model/BlogModel.dart';
import 'package:rafay_portfolio/constants/screensSize/screentype.dart';
import 'package:rafay_portfolio/constants/scrollAnimation/scrollAnimation.dart';
import 'package:rafay_portfolio/constants/widgets/text/textstyle.dart';
import 'package:rafay_portfolio/constants/widgets/ultis/HoverChip.dart';

// ----------------------------
// ReadMeBlogs Widget
// ----------------------------
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
  // ----------------------------
  // Conrollers
  // ----------------------------
  late ScrollController _scrollController;
  final ValueNotifier<double> _progress = ValueNotifier(0);
  final controller = AutoScrollController();

  // ----------------------------
  // Initialization
  // ----------------------------
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        _progress.value = _scrollController.offset /
            _scrollController.position.maxScrollExtent;
      });
  }

  // ----------------------------
  // Dispose
  // ----------------------------
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ----------------------------
  // Display Blog Post
  // ----------------------------

  //Orginal Code for getting Blog Post without Auto Routes and URL
  Future<BlogPosModel> getReleatedBlogPost() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('blogPosts')
        .doc(widget.id)
        .get();
    return BlogPosModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  //Version 07:
  Future<BlogPosModel> getBlogPost({String? url}) async {
    QuerySnapshot querySnapshot;
    // print('URL: $url');

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

  // ----------------------------
  // Build Widget
  // ----------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<BlogPosModel>(
        future: getBlogPost(url: widget.url),
        builder: (BuildContext context, AsyncSnapshot<BlogPosModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingIndicator(context);
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');

            return buildErrorWidget(context);
          } else {
            return buildBlogContent(context, snapshot.data!);
          }
        },
      ),
    );
  }

  // ----------------------------
  // App Bar Widegt
  // ----------------------------
  AppBar buildAppBar(BuildContext context) {
    ScreenType screenType = ScreenType(MediaQuery.of(context).size.width);
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: screenType.isMobile
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      backgroundColor: Theme.of(context).colorScheme.background,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0),
        child: ValueListenableBuilder<double>(
          valueListenable: _progress,
          builder: (context, value, child) {
            return LinearProgressIndicator(
              value: value,
              backgroundColor: Theme.of(context).colorScheme.background,
              color: Theme.of(context).colorScheme.inversePrimary,
              minHeight: 3.0,
            );
          },
        ),
      ),
    );
  }

  // ----------------------------
  // Loading Indicator
  // ----------------------------
  Widget buildLoadingIndicator(BuildContext context) {
    ScreenType screenType = ScreenType(MediaQuery.of(context).size.width);
    return Center(
      child: Padding(
        padding: screenType.isMobile
            ? const EdgeInsets.only(left: 10.0, right: 10.0)
            : const EdgeInsets.only(left: 400.0, right: 400.0),
        child: FAProgressBar(
          currentValue: 100,
          size: 10,
          backgroundColor: Theme.of(context).colorScheme.background,
          progressColor: Theme.of(context).colorScheme.inversePrimary,
          maxValue: 100,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }

  // ----------------------------
  // Error handelling
  // ----------------------------
  Widget buildErrorWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, right: 8.0, top: 20.0, bottom: 20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Lottie.asset('assets/animation/datanotfound.json'),
            const SizedBox(height: 10),
            StyledText(
              text: "Sorry!! No search results found. ",
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
              textAlign: TextAlign.center,
              bold: true,
            )
          ],
        ),
      ),
    );
  }

  // ----------------------------
  // build Blogs Content
  // ----------------------------
  Widget buildBlogContent(BuildContext context, BlogPosModel data) {
    ScreenType screenType = ScreenType(MediaQuery.of(context).size.width);
    // ----------------------------
    // Extract Heading
    // ----------------------------
    List<Map<String, dynamic>> extractHeadings(String htmlContent) {
      dom.Document document = htmlParser.parse(htmlContent);
      List<dom.Element> headingElements =
          document.querySelectorAll('h1, h2, h3, h4, h5, h6');

      return headingElements.map((element) {
        String? level = element.localName;
        return {'level': level, 'text': element.text};
      }).toList();
    }

    // ----------------------------
    // Identify Content Type
    //   1. HTML
    //   2. Markdown
    // ----------------------------

    Widget renderContent(String content) {
      RegExp htmlRegex = RegExp(
        r'(<[a-z1-6]+>)|' + // Start tags
            r'(</[a-z1-6]+>)|' + // End tags
            r'(<!--.*?-->)|' + // Comments
            r'(<[a-z1-6]+/>)|' + // Self-closing tags
            r'(<[a-z1-6]+ [^>]*>)', // Tags with attributes
        multiLine: true,
        caseSensitive: false,
      );

      RegExp markdownRegex = RegExp(
        r'(#{1,6}[^\n]+|' + // Headers
            r'\*{1,2}[^\*]+\*{1,2}|' + // Emphasis and strong emphasis
            r'\[[^\]]+\]\([^\)]+\)|' + // Links
            r'!\[[^\]]+\]\([^\)]+\)|' + // Images
            r'`[^`]+`|' + // Code
            r'> [^\n]+|' + // Blockquotes
            r'^\* [^\n]+|' + // Unordered list
            r'^\d+\. [^\n]+|' + // Ordered list
            r'^-{3,})', // Horizontal rule
        multiLine: true,
      );

      if (htmlRegex.hasMatch(content)) {
        return Html(
          data: content,
          style: {
            "body": Style(
              textAlign: TextAlign.justify,
              fontSize: FontSize(18.0),
              fontFamily: 'ABeeZee',
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.background,
            ),
            "code": Style(
              backgroundColor: Colors.grey.shade200,
            ),
            "pre": Style(
              padding: HtmlPaddings.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
              backgroundColor: Theme.of(context).colorScheme.background,
              color: Theme.of(context).colorScheme.primary,
              fontFamily: 'monospace',
              fontStyle: htmlRegex.hasMatch(content)
                  ? FontStyle.normal
                  : FontStyle.italic,
              fontSize: FontSize(16.0),
              border: Border.all(
                color: Theme.of(context).colorScheme.inversePrimary,
                width: 2,
              ), // Add this line
            ),
          },
        );
      } else if (markdownRegex.hasMatch(content)) {
        return Markdown(
          data: content,
        );
      } else {
        return Text(content);
      }
    }

    // ----------------------------
    // Table of Contents
    // ----------------------------
    List<Map<String, dynamic>> tableOfContents = extractHeadings(data.content);

    // ----------------------------
    // Blog Content
    // ----------------------------
    return SingleChildScrollView(
      // ----------------------------
      // Custom Scroll Behavior
      // ----------------------------
      physics: const CustomScrollPhysics(),
      controller: _scrollController,
      // ----------------------------
      // One Main Column
      // ----------------------------
      child: Column(
        children: [
          // ----------------------------
          // Thumbnail
          // ----------------------------
          SizedBox(
            width: double.infinity,
            child: ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.5,
                child: kIsWeb
                    ? Image.network(
                        data.thumbnail,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('Error loading image');
                        },
                      )
                    : CachedNetworkImage(
                        imageUrl: data.thumbnail,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Text('Error loading image'),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // ----------------------------
          // One Main Column
          // ----------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // -----------------------------------------
                    // Different Padding for Mobile and Web
                    // -----------------------------------------
                    const SizedBox(height: 15),
                    // ----------------------------
                    // Title
                    // ----------------------------
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
                    // ----------------------------
                    // Sub Title
                    // ----------------------------
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
                    // ----------------------------
                    // Date and time
                    // ----------------------------
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
                    // ----------------------------
                    // Author
                    // ----------------------------

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
                        text: "URL: ${data.url}",
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                    const SizedBox(height: 10),
                    // ----------------------------
                    // Blog Tage
                    // ----------------------------
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
                    const SizedBox(height: 20),
                    // -------------------------------------------------
                    // Render Blog Content on the base of Content Type
                    // -------------------------------------------------
                    Padding(
                      padding: screenType.isMobile
                          ? const EdgeInsets.only(left: 15.0, right: 15.0)
                          : const EdgeInsets.only(left: 35.0, right: 35.0),
                      child: renderContent(data.content),
                    ),
                    const SizedBox(height: 20),

                    const SizedBox(height: 35),
                    // ---------------------------
                    // Get Related Blog
                    // ---------------------------

                    //User Comments Near Future
                  ],
                ),
              ),
              // ---------------------------------
              //  This is only visiable for web
              //  No Table content for Mobile
              // ---------------------------------
              if (MediaQuery.of(context).size.width > 600)
                Expanded(
                  flex: 1,
                  child: MediaQuery.of(context).size.width > 600
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: StyledText(
                                text: "Written By:",
                                fontSize: 30,
                                color: Theme.of(context).colorScheme.primary,
                                bold: true,
                                fontFamily: 'ABeeZee',
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/image/author.jpg"),
                                  radius: 20,
                                ),
                                const SizedBox(width: 10),
                                StyledText(
                                  text: data.author,
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                  bold: false,
                                  fontFamily: 'ABeeZee',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: StyledText(
                                text: "In this Article:",
                                fontSize: 30,
                                color: Theme.of(context).colorScheme.primary,
                                bold: true,
                                fontFamily: 'ABeeZee',
                              ),
                            ),
                            const SizedBox(height: 15),
                            Column(
                              children:
                                  tableOfContents.asMap().entries.map((entry) {
                                int idx = entry.key;
                                Map<String, dynamic> heading = entry.value;
                                double fontSize;
                                double paddingLeft;
                                switch (heading['level']) {
                                  case 'h1':
                                    fontSize = 18;
                                    paddingLeft = 20.0;
                                    break;
                                  case 'h2':
                                    fontSize = 16;
                                    paddingLeft = 40.0;
                                    break;
                                  case 'h3':
                                    fontSize = 14;
                                    paddingLeft = 60.0;
                                    break;
                                  case 'h4':
                                    fontSize = 12;
                                    paddingLeft = 80.0;
                                    break;
                                  case 'h5':
                                    fontSize = 12;
                                    paddingLeft = 100.0;
                                    break;
                                  case 'h6':
                                    fontSize = 12;
                                    paddingLeft = 120.0;
                                    break;
                                  default:
                                    fontSize = 18;
                                    paddingLeft = 20.0;
                                    break;
                                }
                                // ----------------------------
                                // Auto Scroll Tag
                                // ----------------------------
                                return AutoScrollTag(
                                  index: idx,
                                  key: ValueKey(idx),
                                  controller: controller,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: paddingLeft),
                                    child: ListTile(
                                      leading: Icon(Icons.label,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary),
                                      title: StyledText(
                                        text: heading['text'],
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontFamily: 'ABeeZee',
                                      ),
                                      onTap: () async {
                                        await controller.scrollToIndex(idx,
                                            preferPosition:
                                                AutoScrollPosition.middle);
                                      },
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        )
                      // -------------------------------------------------
                      // For Mobile View Replace the Flex with container
                      // -------------------------------------------------
                      : Container(), // Empty container for mobile view
                ),
              const SizedBox(height: 25),
            ],
          ),
        ],
      ),
    );
  }
}
