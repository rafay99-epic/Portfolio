// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class BlogPosModel {
  String title;
  String subTitle;
  String thumbnail;
  String url;
  bool isEnabled;
  List<String> tags;
  String author;
  String content;
  DateTime date;

  BlogPosModel({
    required this.title,
    required this.subTitle,
    required this.thumbnail,
    required this.url,
    required this.isEnabled,
    required this.tags,
    required this.author,
    required this.content,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subTitle': subTitle,
      'thumbnail': thumbnail,
      'url': url,
      'isEnabled': isEnabled,
      'tags': tags,
      'author': author,
      'content': content,
      'date': date.toIso8601String(),
    };
  }

  static BlogPosModel fromMap(Map<String, dynamic> map) {
    return BlogPosModel(
      title: map['title'] ?? '',
      subTitle: map['subTitle'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      url: map['url'] ?? '',
      isEnabled: map['isEnabled'] ?? false,
      tags: List<String>.from(map['tags'] ?? []),
      author: map['author'] ?? '',
      content: map['content'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
    );
  }
}
