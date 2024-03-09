// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

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
  io.File? _image;

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
        title: const Text('Add Blog Post'),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  // Save the blog post
                  var blogPost = {
                    'title': titleController.text,
                    'subTitle': subTitleController.text,
                    'isEnabled': isEnabled,
                    'tags': tagsController.text.split(','),
                    'author': authorController.text,
                    'content': await controller.getText(),
                  };

                  //! The File Upload code is not working, Even Possiable that the File is
                  //! not Uploading OR the URL for the file is not downloading.
                  // // Upload the thumbnail to Firebase Storage
                  // if (_image != null) {
                  //   var snapshot = await FirebaseStorage.instance
                  //       .ref('thumbnails/${path.basename(_image!.path)}')
                  //       .putFile(_image!);
                  //   var downloadUrl = await snapshot.ref.getDownloadURL();

                  //   // Add the download URL to the blog post
                  //   blogPost['thumbnail'] = downloadUrl;
                  // } else {
                  //   print('No image selected to upload.');
                  // }

                  // Save the blog post to Firestore
                  await FirebaseFirestore.instance
                      .collection('blogPosts')
                      .add(blogPost);

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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  setState(() {
                    _image = io.File(pickedFile.path);
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
              htmlEditorOptions: const HtmlEditorOptions(
                hint: "Write your Blog here...",
              ),
              otherOptions: const OtherOptions(
                height: 800,
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.background,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            try {
              // Save the blog post
              var blogPost = {
                'title': titleController.text,
                'subTitle': subTitleController.text,
                'isEnabled': isEnabled,
                'tags': tagsController.text.split(','),
                'author': authorController.text,
                'content': await controller.getText(),
              };

              //! The File Upload code is not working, Even Possiable that the File is
              //! not Uploading OR the URL for the file is not downloading.

              // var snapshot = await FirebaseStorage.instance
              //  .ref('thumbnails/${path.basename(_image!.path)}')
              //  .putFile(_image!);
              // var downloadUrl = await snapshot.ref.getDownloadURL();
              // Upload the thumbnail to Firebase Storage
              // if (_image != null) {
              //   var snapshot = await FirebaseStorage.instance
              //       .ref('thumbnails/${path.basename(_image!.path)}')
              //       .putFile(_image!);
              //   var downloadUrl = await snapshot.ref.getDownloadURL();

              //   // Add the download URL to the blog post
              //   blogPost['thumbnail'] = downloadUrl;
              // } else {
              //   print('No image selected to upload.');
              // }

              // Save the blog post to Firestore
              await FirebaseFirestore.instance
                  .collection('blogPosts')
                  .add(blogPost);

              // Show a dialog saying that the blog is added
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Blog Added'),
                  content: Text('The blog post has been successfully added.'),
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
        child: const Icon(Icons.save),
      ),
    );
  }
}
