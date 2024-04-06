// Extract Heading
// ----------------------------

// ignore_for_file: depend_on_referenced_packages, library_prefixes

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlParser;

List<Map<String, dynamic>> extractHeadings(String htmlContent) {
  dom.Document document = htmlParser.parse(htmlContent);
  List<dom.Element> headingElements =
      document.querySelectorAll('h1, h2, h3, h4, h5, h6');

  return headingElements.map((element) {
    String? level = element.localName;
    return {'level': level, 'text': element.text};
  }).toList();
}
