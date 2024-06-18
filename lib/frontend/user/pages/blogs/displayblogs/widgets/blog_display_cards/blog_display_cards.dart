import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rafay_portfolio/constants/widgets/ultis/HoverChip.dart';

class BlogCard extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const BlogCard({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: Theme.of(context).colorScheme.inversePrimary,
          width: 3,
        ),
      ),
      color: Theme.of(context).colorScheme.primary,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: SizedBox(
                  child: Image.network(
                    doc['thumbnail'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Error loading image');
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildRichText('Title: ', doc['title'], context),
                  const SizedBox(height: 10),
                  buildRichText('Author: ', doc['author'], context),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: List<Widget>.generate(
                        doc['tags'].length,
                        (int index) {
                          return HoverChip(label: doc['tags'][index]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRichText(String label, String value, BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: label,
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
                fontFamily: "roboto",
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).colorScheme.surface,
                fontFamily: "roboto",
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
