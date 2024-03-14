// ignore_for_file: library_private_types_in_public_api, library_prefixes, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lottie/lottie.dart';
import 'package:rafay_portfolio/admin/backend/model/BlogModel.dart';
import 'package:rafay_portfolio/user/frontend/widgets/HoverChip.dart';
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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<BlogPosModel>(
        future: getBlogPost(),
        builder: (BuildContext context, AsyncSnapshot<BlogPosModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 400.0, right: 400.0),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 35, right: 35),
                          child: StyledText(
                            text: data.title,
                            fontSize: 40,
                            color: Theme.of(context).colorScheme.primary,
                            bold: true,
                            fontFamily: 'ABeeZee',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 35, right: 35),
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
                          padding: const EdgeInsets.only(left: 35, right: 35),
                          child: StyledText(
                            text: "Date: ${data.date}",
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 35, right: 35),
                          child: StyledText(
                            text: "Author: ${data.author}",
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 35, right: 35),
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
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 35.0, right: 35.0),
                          child: Html(
                            data: data.content,
                            style: {
                              "body": Style(
                                textAlign: TextAlign.justify,
                                fontSize: FontSize(18.0),
                                fontFamily: 'ABeeZee',
                                color: Theme.of(context).colorScheme.primary,
                                backgroundColor:
                                    Theme.of(context).colorScheme.background,
                              ),
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0, right: 35),
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
                                height: 500.0,
                                width: 800.0,
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
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 35, right: 35),
                          child: StyledText(
                            text: "Table of Contents",
                            fontSize: 30,
                            color: Theme.of(context).colorScheme.primary,
                            bold: true,
                            fontFamily: 'ABeeZee',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              tableOfContents.asMap().entries.map((entry) {
                            int idx = entry.key;
                            String heading = entry.value;
                            return Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 50,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: idx == 0 ? 0 : 50,
                                        child: VerticalDivider(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline,
                                          thickness: 3,
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      SizedBox(
                                        height:
                                            idx == tableOfContents.length - 1
                                                ? 0
                                                : 50,
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
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
                    ),
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
