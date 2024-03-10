// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:rafay_portfolio/admin/backend/blog/blogAdd.dart';
import 'package:rafay_portfolio/user/frontend/widgets/textstyle.dart';

class AddBlogPost extends StatefulWidget {
  const AddBlogPost({Key? key}) : super(key: key);

  @override
  State<AddBlogPost> createState() => _AddBlogPostState();
}

class _AddBlogPostState extends State<AddBlogPost> {
  HtmlEditorController controller = HtmlEditorController();

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final subTitleController = TextEditingController();
  final tagsController = TextEditingController();
  final authorController = TextEditingController();
  bool isEnabled = false;
  // io.File? _image;
  Uint8List? _image;

  @override
  void dispose() {
    titleController.dispose();
    subTitleController.dispose();
    tagsController.dispose();
    authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledText(
          text: 'Add Blog Post',
          fontSize: 22,
          color: Theme.of(context).colorScheme.primary,
          textAlign: TextAlign.left,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.background,
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                shape: RoundedRectangleBorder(
                  // Rounded corners
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    if (_image != null) {
                      await addBlogPost(
                        title: titleController.text,
                        subTitle: subTitleController.text,
                        isEnabled: isEnabled,
                        tags: tagsController.text.split(','),
                        author: authorController.text,
                        content: await controller.getText(),
                        imageFile: _image!,
                      );
                    } else {
                      print('No image selected.');
                    }

                    titleController.clear();
                    subTitleController.clear();
                    tagsController.clear();
                    authorController.clear();
                    isEnabled = false;
                    controller.clear();

                    // Show a dialog saying that the blog is added
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Blog Added'),
                        content:
                            Text('The blog post has been successfully added.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  } catch (e) {
                    // Show a dialog with the error message
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text(e.toString()),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              child: Text('Save Blog Post'),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(fontSize: 18),
              ),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: subTitleController,
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(fontSize: 18),
              ),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              "Update Blog Thumbnail",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final imageInfo = await ImagePickerWeb.getImageInfo;
                if (imageInfo != null) {
                  setState(() {
                    _image = imageInfo.data;
                  });
                } else {
                  print('No image selected.');
                }
              },
              child: const Text('Upload Thumbnail'),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text(
                'Enabled',
                style: TextStyle(fontSize: 18),
              ),
              value: isEnabled,
              onChanged: (value) {
                setState(() {
                  isEnabled = value ?? false;
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: tagsController,
              decoration: const InputDecoration(
                labelText: 'Tags (comma separated)',
                labelStyle: TextStyle(fontSize: 18),
              ),
              style: const TextStyle(fontSize: 18),
            ),
            TextFormField(
              controller: authorController,
              decoration: const InputDecoration(
                labelText: 'Author',
                labelStyle: TextStyle(fontSize: 18),
              ),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            HtmlEditor(
              controller: controller, //required
              htmlEditorOptions: HtmlEditorOptions(
                hint: "Write your Blog here...",
                autoAdjustHeight: true,
                spellCheck: true,
                darkMode: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
