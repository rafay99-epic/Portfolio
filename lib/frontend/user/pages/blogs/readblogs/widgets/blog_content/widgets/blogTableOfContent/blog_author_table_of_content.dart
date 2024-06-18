// -------------------------------------
// Author Name and table of Contents
// -------------------------------------
import 'package:flutter/material.dart';
import 'package:rafay_portfolio/backend/model/BlogModel.dart';
import 'package:rafay_portfolio/constants/widgets/text/textstyle.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class BlogAuthorAndContents extends StatelessWidget {
  final BlogPosModel data;
  final AutoScrollController autoScrollController;
  final List<Map<String, dynamic>> tableOfContents;

  const BlogAuthorAndContents({
    super.key,
    required this.data,
    required this.autoScrollController,
    required this.tableOfContents,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
              backgroundImage: AssetImage("assets/image/author.jpg"),
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
          children: tableOfContents.asMap().entries.map((entry) {
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
              controller: autoScrollController,
              child: Padding(
                padding: EdgeInsets.only(left: paddingLeft),
                child: ListTile(
                  leading: Icon(Icons.label,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  title: StyledText(
                    text: heading['text'],
                    fontSize: fontSize,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: 'ABeeZee',
                  ),
                  onTap: () async {
                    await autoScrollController.scrollToIndex(idx,
                        preferPosition: AutoScrollPosition.middle);
                  },
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
