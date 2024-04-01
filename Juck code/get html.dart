    // Widget renderContent(String content) {
    //   RegExp htmlRegex = RegExp(
    //     r'(<[a-z1-6]+>)|' + // Start tags
    //         r'(</[a-z1-6]+>)|' + // End tags
    //         r'(<!--.*?-->)|' + // Comments
    //         r'(<[a-z1-6]+/>)|' + // Self-closing tags
    //         r'(<[a-z1-6]+ [^>]*>)', // Tags with attributes
    //     multiLine: true,
    //     caseSensitive: false,
    //   );

    //   RegExp markdownRegex = RegExp(
    //     r'(#{1,6}[^\n]+|' + // Headers
    //         r'\*{1,2}[^\*]+\*{1,2}|' + // Emphasis and strong emphasis
    //         r'\[[^\]]+\]\([^\)]+\)|' + // Links
    //         r'!\[[^\]]+\]\([^\)]+\)|' + // Images
    //         r'`[^`]+`|' + // Code
    //         r'> [^\n]+|' + // Blockquotes
    //         r'^\* [^\n]+|' + // Unordered list
    //         r'^\d+\. [^\n]+|' + // Ordered list
    //         r'^-{3,})', // Horizontal rule
    //     multiLine: true,
    //   );

    //   if (htmlRegex.hasMatch(content)) {
    //     return HtmlWidget(
    //       content,
    //       customWidgetBuilder: (element) {
    //         Widget? widget;
    //         if (element.localName == 'pre') {
    //           return Stack(
    //             children: <Widget>[
    //               Container(
    //                 decoration: BoxDecoration(
    //                   border: Border.all(
    //                       color: Theme.of(context).colorScheme.inversePrimary),
    //                   color: Theme.of(context).colorScheme.background,
    //                 ),
    //                 child: LimitedBox(
    //                   maxHeight: 200.0,
    //                   child: SingleChildScrollView(
    //                     scrollDirection: Axis.vertical,
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: StyledText(
    //                         text: element.text,
    //                         fontSize: 16.0,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Positioned(
    //                 top: 0,
    //                 right: 0,
    //                 child: IconButton(
    //                   icon: Icon(
    //                     Icons.copy,
    //                     color: Theme.of(context).colorScheme.primary,
    //                   ),
    //                   onPressed: () {
    //                     Clipboard.setData(ClipboardData(text: element.text));
    //                   },
    //                 ),
    //               ),
    //             ],
    //           );
    //         } else if (element.localName == 'body') {
    //           return StyledText(
    //             text: element.text,
    //             fontSize: 18.0,
    //             color: Theme.of(context).colorScheme.primary,
    //             fontFamily: 'ABeeZee',
    //             textAlign: TextAlign.justify,
    //           );
    //         } else if (element.localName == 'p') {
    //           return StyledText(
    //             text: element.text,
    //             fontSize: 18.0,
    //             color: Theme.of(context).colorScheme.primary,
    //             fontFamily: 'ABeeZee',
    //             textAlign: TextAlign.justify,
    //           );
    //         } else if (element.localName == 'h1') {
    //           return StyledText(
    //             text: element.text,
    //             fontSize: 28.0,
    //             bold: true,
    //             color: Theme.of(context).colorScheme.primary,
    //             fontFamily: 'ABeeZee',
    //             textAlign: TextAlign.justify,
    //           );
    //         } else if (element.localName == 'h2') {
    //           return StyledText(
    //             text: element.text,
    //             fontSize: 24.0,
    //             color: Theme.of(context).colorScheme.primary,
    //             fontFamily: 'ABeeZee',
    //             textAlign: TextAlign.justify,
    //             bold: true,
    //           );
    //         } else if (element.localName == 'h3') {
    //           return StyledText(
    //             text: element.text,
    //             bold: true,
    //             fontSize: 20.0,
    //             color: Theme.of(context).colorScheme.primary,
    //             fontFamily: 'ABeeZee',
    //             textAlign: TextAlign.justify,
    //           );
    //         } else if (element.localName == 'h4') {
    //           return StyledText(
    //             text: element.text,
    //             bold: true,
    //             fontSize: 18.0,
    //             color: Theme.of(context).colorScheme.primary,
    //             fontFamily: 'ABeeZee',
    //             textAlign: TextAlign.justify,
    //           );
    //         } else if (element.localName == 'h5') {
    //           return StyledText(
    //             text: element.text,
    //             fontSize: 16.0,
    //             bold: true,
    //             color: Theme.of(context).colorScheme.primary,
    //             fontFamily: 'ABeeZee',
    //             textAlign: TextAlign.justify,
    //           );
    //         } else if (element.localName == 'h6') {
    //           return StyledText(
    //             text: element.text,
    //             fontSize: 14.0,
    //             bold: true,
    //             color: Theme.of(context).colorScheme.primary,
    //             fontFamily: 'ABeeZee',
    //             textAlign: TextAlign.justify,
    //           );
    //         }
    //         if (widget != null) {
    //           widget = Padding(
    //             padding: const EdgeInsets.symmetric(vertical: 8.0),
    //             child: widget,
    //           );
    //         }
    //         return widget;
    //       },
    //     );
    //   } else if (markdownRegex.hasMatch(content)) {
    //     return Markdown(
    //       data: content,
    //     );
    //   } else {
    //     return Text(content);
    //   }
    // }









    // orginal code for rendering content
    // Widget renderContent(String content) {
    //   RegExp htmlRegex = RegExp(
    //     r'(<[a-z1-6]+>)|' + // Start tags
    //         r'(</[a-z1-6]+>)|' + // End tags
    //         r'(<!--.*?-->)|' + // Comments
    //         r'(<[a-z1-6]+/>)|' + // Self-closing tags
    //         r'(<[a-z1-6]+ [^>]*>)', // Tags with attributes
    //     multiLine: true,
    //     caseSensitive: false,
    //   );

    //   RegExp markdownRegex = RegExp(
    //     r'(#{1,6}[^\n]+|' + // Headers
    //         r'\*{1,2}[^\*]+\*{1,2}|' + // Emphasis and strong emphasis
    //         r'\[[^\]]+\]\([^\)]+\)|' + // Links
    //         r'!\[[^\]]+\]\([^\)]+\)|' + // Images
    //         r'`[^`]+`|' + // Code
    //         r'> [^\n]+|' + // Blockquotes
    //         r'^\* [^\n]+|' + // Unordered list
    //         r'^\d+\. [^\n]+|' + // Ordered list
    //         r'^-{3,})', // Horizontal rule
    //     multiLine: true,
    //   );

    //   if (htmlRegex.hasMatch(content)) {
    //     return Html(
    //       data: content,
    //       style: {
    //         "body": Style(
    //           textAlign: TextAlign.justify,
    //           fontSize: FontSize(18.0),
    //           fontFamily: 'ABeeZee',
    //           color: Theme.of(context).colorScheme.primary,
    //           backgroundColor: Theme.of(context).colorScheme.background,
    //         ),
    //       },
    //     );
    //   } else if (markdownRegex.hasMatch(content)) {
    //     return Markdown(
    //       data: content,
    //     );
    //   } else {
    //     return Text(content);
    //   }
    // }