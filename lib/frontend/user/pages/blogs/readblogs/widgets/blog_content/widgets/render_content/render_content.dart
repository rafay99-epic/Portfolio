// ----------------------------
// Identify Content Type
//   1. HTML
//   2. Markdown
// ----------------------------
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

Widget renderContent(String content, BuildContext context) {
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
          fontStyle:
              htmlRegex.hasMatch(content) ? FontStyle.normal : FontStyle.italic,
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
