import 'package:flutter/material.dart';

class AddBlogPost extends StatefulWidget {
  const AddBlogPost({Key? key}) : super(key: key);

  @override
  State<AddBlogPost> createState() => _AddBlogPostState();
}

class _AddBlogPostState extends State<AddBlogPost> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String subTitle = '';
  String thumbnail = '';
  String url = '';
  bool isEnabled = false;
  List<String> tags = [];
  DateTime date = DateTime.now();
  String author = '';
  DateTime timestamp = DateTime.now();
  List<String> contentBlocks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Blog Post'),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Sub Title'),
              onChanged: (value) {
                setState(() {
                  subTitle = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Implement your image picking logic here
              },
              child: Text('Upload Thumbnail'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'URL'),
              onChanged: (value) {
                setState(() {
                  url = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Enabled'),
              value: isEnabled,
              onChanged: (value) {
                setState(() {
                  isEnabled = value ?? false;
                });
              },
            ),
            // Add more fields here for subTitle, thumbnail, url, isEnabled, tags, date, author, timestamp, and contentBlocks
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Save the blog post
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
