// enum ContentType { text, image, code }

// class ContentBlock {
//   final ContentType type;
//   final String content;

//   ContentBlock({
//     required this.type,
//     required this.content,
//   });
// }

// class BlogPost {
//   final String title;
//   final String subTitle;
//   final String thumbnail;
//   final String url;
//   final bool isEnabled;
//   final List<String> tags;
//   final DateTime date;
//   final String author;
//   final DateTime timestamp;
//   final List<ContentBlock> contentBlocks;

//   BlogPost({
//     required this.title,
//     required this.subTitle,
//     required this.thumbnail,
//     required this.url,
//     required this.isEnabled,
//     required this.tags,
//     required this.date,
//     required this.author,
//     required this.timestamp,
//     required this.contentBlocks,
//   });
// }
enum ContentType { text, image, code }

class ContentBlock {
  final ContentType type;
  final String content;

  ContentBlock({
    required this.type,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type.index,
      'content': content,
    };
  }

  static ContentBlock fromMap(Map<String, dynamic> map) {
    return ContentBlock(
      type: ContentType.values[map['type']],
      content: map['content'],
    );
  }
}

class BlogPost {
  final String title;
  final String subTitle;
  final String thumbnail;
  final String url;
  final bool isEnabled;
  final List<String> tags;
  final DateTime date;
  final String author;
  final DateTime timestamp;
  final List<ContentBlock> contentBlocks;

  BlogPost({
    required this.title,
    required this.subTitle,
    required this.thumbnail,
    required this.url,
    required this.isEnabled,
    required this.tags,
    required this.date,
    required this.author,
    required this.timestamp,
    required this.contentBlocks,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subTitle': subTitle,
      'thumbnail': thumbnail,
      'url': url,
      'isEnabled': isEnabled,
      'tags': tags,
      'date': date.toIso8601String(),
      'author': author,
      'timestamp': timestamp.toIso8601String(),
      'contentBlocks': contentBlocks.map((block) => block.toMap()).toList(),
    };
  }

  static BlogPost fromMap(Map<String, dynamic> map) {
    return BlogPost(
      title: map['title'],
      subTitle: map['subTitle'],
      thumbnail: map['thumbnail'],
      url: map['url'],
      isEnabled: map['isEnabled'],
      tags: List<String>.from(map['tags']),
      date: DateTime.parse(map['date']),
      author: map['author'],
      timestamp: DateTime.parse(map['timestamp']),
      contentBlocks: List<ContentBlock>.from(map['contentBlocks']
          .map((blockMap) => ContentBlock.fromMap(blockMap))),
    );
  }
}
