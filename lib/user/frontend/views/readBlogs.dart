// ignore_for_file: library_private_types_in_public_api, library_prefixes, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lottie/lottie.dart';
import 'package:rafay_portfolio/admin/backend/model/BlogModel.dart';
import 'package:rafay_portfolio/user/frontend/views/ProjectGallery.dart';
import 'package:rafay_portfolio/user/frontend/widgets/HoverChip.dart';
import 'package:rafay_portfolio/user/frontend/widgets/scrollAnimation.dart';
import 'package:rafay_portfolio/user/frontend/widgets/textstyle.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as dom;

class ReadMeBlogs extends StatefulWidget {
  final String id;

  const ReadMeBlogs({Key? key, required this.id}) : super(key: key);

  @override
  _ReadMeBlogsState createState() => _ReadMeBlogsState();
}

class _ReadMeBlogsState extends State<ReadMeBlogs> {
  late ScrollController _scrollController;
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

  //Fetching Data from Firestore
  Future<BlogPosModel> getBlogPost() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('blogPosts')
        .doc(widget.id)
        .get();
    return BlogPosModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    //extract Table of content
    List<String> extractHeadings(String htmlContent) {
      dom.Document document = htmlParser.parse(htmlContent);
      List<dom.Element> headingElements =
          document.querySelectorAll('h1, h2, h3, h4, h5, h6');
      return headingElements.map((element) => element.text).toList();
    }

    //widget for determin content and then render the content
    // Orginal Code
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

    //Screen Type
    ScreenType screenType = ScreenType(MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: AppBar(
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
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<BlogPosModel>(
        future: getBlogPost(),
        builder: (BuildContext context, AsyncSnapshot<BlogPosModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
          } else if (snapshot.hasError) {
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
          } else {
            BlogPosModel data = snapshot.data!;
            List<String> tableOfContents = extractHeadings(data.content);
            return SingleChildScrollView(
              physics: const CustomScrollPhysics(),
              controller: _scrollController,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 10),
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
                              ? const EdgeInsets.only(left: 15.0, right: 15.0)
                              : const EdgeInsets.only(left: 35.0, right: 35.0),
                          child: StyledText(
                            text: "Date: ${data.date}",
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: screenType.isMobile
                              ? const EdgeInsets.only(left: 15.0, right: 15.0)
                              : const EdgeInsets.only(left: 35.0, right: 35.0),
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
                              ? const EdgeInsets.only(left: 15.0, right: 15.0)
                              : const EdgeInsets.only(left: 35.0, right: 35.0),
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

                        //Rendering the content
                        Padding(
                          padding: screenType.isMobile
                              ? const EdgeInsets.only(left: 15.0, right: 15.0)
                              : const EdgeInsets.only(left: 35.0, right: 35.0),
                          child: renderContent(data.content),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: screenType.isMobile
                              ? const EdgeInsets.only(left: 15.0, right: 15.0)
                              : const EdgeInsets.only(left: 35.0, right: 35.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: StyledText(
                              text: "Thumbnail",
                              fontSize: 40,
                              color: Theme.of(context).colorScheme.primary,
                              bold: true,
                              fontFamily: 'ABeeZee',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.1,
                              right: MediaQuery.of(context).size.width * 0.1,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Image.network(
                                  data.thumbnail,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text('Error loading image');
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),

                        //User Comments Near Future
                      ],
                    ),
                  ),
                  if (MediaQuery.of(context).size.width > 600)
                    Expanded(
                      flex: 1,
                      child: MediaQuery.of(context).size.width > 600
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 150,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35, right: 35),
                                  child: StyledText(
                                    text: "Table of Contents",
                                    fontSize: 30,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    bold: true,
                                    fontFamily: 'ABeeZee',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: tableOfContents
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    int idx = entry.key;
                                    String heading = entry.value;
                                    return Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 50,
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: idx == 0 ? 0 : 25,
                                                child: VerticalDivider(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .outline,
                                                  thickness: 3,
                                                ),
                                              ),
                                              CircleAvatar(
                                                radius: 10,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                              ),
                                              SizedBox(
                                                height: idx ==
                                                        tableOfContents.length -
                                                            1
                                                    ? 0
                                                    : 25,
                                                child: VerticalDivider(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .outline,
                                                  thickness: 3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            title: StyledText(
                                              text: heading,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontFamily: 'ABeeZee',
                                            ),
                                            onTap: () {
                                              // Handle tap
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ],
                            )
                          : Container(), // Empty container for mobile view
                    ),
                  const SizedBox(height: 25),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
