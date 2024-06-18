// ----------------------------
// Identify Content Type
//   1. HTML
//   2. Markdown
// ----------------------------
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:rafay_portfolio/constants/widgets/ultis/copyButton.dart';

Widget renderContent(String content, BuildContext context) {
  RegExp htmlRegex = RegExp(
    r'(<[a-z1-6]+>)|'
    r'(</[a-z1-6]+>)|'
    r'(<!--.*?-->)|'
    r'(<[a-z1-6]+/>)|'
    r'(<[a-z1-6]+ [^>]*>)', // Tags with attributes
    multiLine: true,
    caseSensitive: false,
  );

  RegExp markdownRegex = RegExp(
    r'(#{1,6}[^\n]+|'
    r'\*{1,2}[^\*]+\*{1,2}|'
    r'\[[^\]]+\]\([^\)]+\)|'
    r'!\[[^\]]+\]\([^\)]+\)|'
    r'`[^`]+`|'
    r'> [^\n]+|'
    r'^\* [^\n]+|'
    r'^\d+\. [^\n]+|'
    r'^-{3,})', // Horizontal rule
    multiLine: true,
  );

  if (htmlRegex.hasMatch(content)) {
    return SelectionArea(
      child: Html(
        data: content,
        style: {
          "body": Style(
            textAlign: TextAlign.justify,
            fontSize: FontSize(18.0),
            fontFamily: 'ABeeZee',
            color: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          "code": Style(
            color: Theme.of(context).colorScheme.primary,
          ),
          "pre": Style(
            padding: HtmlPaddings.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
            backgroundColor: Theme.of(context).colorScheme.surface,
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
      ),

      // Code with Copy Button but not working
      // HtmlWidget(
      //   content,
      //   customStylesBuilder: (element) {
      //     if (element.localName == 'body') {
      //       return {
      //         'text-align': 'justify',
      //         'font-size': '18.0px',
      //         'font-family': 'ABeeZee',
      //         'color': Theme.of(context).colorScheme.primary.toString(),
      //         'background-color':
      //             Theme.of(context).colorScheme.surface.toString(),
      //       };
      //     } else if (element.localName == 'code') {
      //       return {
      //         'color': Theme.of(context).colorScheme.primary.toString(),
      //       };
      //     } else if (element.localName == 'pre') {
      //       return {
      //         'padding': '10.0px',
      //         'background-color':
      //             Theme.of(context).colorScheme.surface.toString(),
      //         'color': Theme.of(context).colorScheme.primary.toString(),
      //         'font-family': 'monospace',
      //         'font-style': htmlRegex.hasMatch(content) ? 'normal' : 'italic',
      //         'font-size': '16.0px',
      //         'border':
      //             '2px solid ${Theme.of(context).colorScheme.inversePrimary.toString()}',
      //       };
      //     }
      //     return null;
      //   },
    );
  } else if (markdownRegex.hasMatch(content)) {
    return Markdown(
      data: content,
      selectable: true,
    );
  } else {
    return SelectionArea(
      child: Text(content),
    );
  }
}

class MyWidgetFactory extends WidgetFactory {
  @override
  Widget? buildText(
      BuildMetadata tree, TextStyleHtml resolved, InlineSpan text) {
    if (tree.element.localName == 'code') {
      return CopyButton(text: text.toPlainText());
    }
    return super.buildText(tree, resolved, text);
  }
}
