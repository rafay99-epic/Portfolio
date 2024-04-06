//---------------------------
// Author Row in each Card
//---------------------------
import 'package:flutter/material.dart';
import 'package:rafay_portfolio/frontend/user/pages/blogs/relatedblogpost/widgets/build_styletext.dart';

Widget buildAuthorRow(String author, context) {
  return Row(
    children: <Widget>[
      const CircleAvatar(
        backgroundImage: AssetImage("assets/image/author.jpg"),
        radius: 20,
      ),
      const SizedBox(width: 10),
      buildStyledText(author, 16.0, FontWeight.normal,
          Theme.of(context).colorScheme.primary),
    ],
  );
}
