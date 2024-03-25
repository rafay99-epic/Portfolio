// ignore_for_file: file_names, library_private_types_in_public_api
import 'package:flutter/material.dart';

import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:rafay_portfolio/backend/article_functionality/article_functionality.dart';

import 'package:rafay_portfolio/backend/model/BlogModel.dart';

import 'package:rafay_portfolio/constants/widgets/buildTextField.dart';
import 'package:rafay_portfolio/constants/widgets/textstyle.dart';

class UpdateBlogPost extends StatefulWidget {
  final String id;

  const UpdateBlogPost(this.id, {Key? key}) : super(key: key);

  @override
  _UpdateBlogPostState createState() => _UpdateBlogPostState();
}

class _UpdateBlogPostState extends State<UpdateBlogPost> {
  final _formKey = GlobalKey<FormState>();
  late Future<DocumentSnapshot> futureBlogPost;
  final titleController = TextEditingController();
  final subTitleController = TextEditingController();
  final tagsController = TextEditingController();
  final authorController = TextEditingController();
  final controller = HtmlEditorController();
  final newdateController = TextEditingController();
  bool isEnabled = false;
  String? _imageUrl;
  html.File? _image;
  DateTime selectedDateController = DateTime.now();
  DateFormat format = DateFormat("MM/dd/yyyy");
  final ArticleFunctionality articleFunctionality = ArticleFunctionality();

  @override
  void initState() {
    super.initState();
    futureBlogPost =
        FirebaseFirestore.instance.collection('blogPosts').doc(widget.id).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: futureBlogPost,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (!snapshot.hasData) {
          return const Center(child: Text('Document does not exist'));
        }

        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        BlogPosModel blogPost = BlogPosModel.fromMap(data);

        titleController.text = blogPost.title;
        subTitleController.text = blogPost.subTitle;
        tagsController.text = blogPost.tags.join(', ');
        authorController.text = blogPost.author;
        isEnabled = blogPost.isEnabled;
        _imageUrl = blogPost.thumbnail;
        selectedDateController = blogPost.date;
        // controller.setText(blogPost.content);
        Future.delayed(const Duration(seconds: 1), () {
          controller.setText(blogPost.content);
        });
        // Use blogPost to build your UI
        return Scaffold(
          appBar: AppBar(
            title: StyledText(
              text: 'Update Article',
              fontSize: 22,
              color: Theme.of(context).colorScheme.primary,
              textAlign: TextAlign.left,
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            actions: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor:
                            Theme.of(context).colorScheme.background,
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        shape: RoundedRectangleBorder(
                          // Rounded corners
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 26, vertical: 16),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            //update Blog Post
                            await articleFunctionality.updateBlogPost(
                              title: titleController.text,
                              subTitle: subTitleController.text,
                              isEnabled: isEnabled,
                              tags: tagsController.text.split(','),
                              author: authorController.text,
                              content: await controller.getText(),
                              imageFile: _image!,
                              date: selectedDateController,
                              id: widget.id,
                            );

                            titleController.clear();
                            subTitleController.clear();
                            tagsController.clear();
                            authorController.clear();
                            isEnabled = false;
                            controller.clear();

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Blog updated'),
                                content: const Text(
                                    'The blog post has been successfully updated.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: Text(e.toString()),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
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
                      child: const Text('Update Blog Post'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                CustomTextField(
                  labelText: 'Article Title',
                  hintText: 'Enter Article Title',
                  prefixIcon: Icons.title,
                  controller: titleController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Article Description',
                  hintText: 'Article Description',
                  prefixIcon: Icons.description,
                  controller: subTitleController,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Update Blog Thumbnail",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                //Image upload and Image Preview
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: ElevatedButton(
                        onPressed: () {
                          html.FileUploadInputElement uploadInput =
                              html.FileUploadInputElement();
                          uploadInput.click();

                          uploadInput.onChange.listen((e) {
                            final files = uploadInput.files;
                            if (files!.length == 1) {
                              final file = files[0];
                              final reader = html.FileReader();
                              reader.readAsDataUrl(file);
                              reader.onLoadEnd.listen((event) {
                                setState(() {
                                  _image = file;
                                  _imageUrl = reader.result as String;
                                });
                              });
                            }
                          });
                        },
                        child: const Text('Upload Thumbnail'),
                      ),
                    ),
                    const SizedBox(height: 15),
                    if (_imageUrl != null)
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            _imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Select date'),
                  ),
                ),
                const SizedBox(height: 10),
                Text("Selected date: ${selectedDateController.toLocal()}"
                    .split(' ')[0]),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: const Text(
                        'Enabled Article ',
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Checkbox(
                        value: isEnabled,
                        onChanged: (value) {
                          setState(() {
                            isEnabled = value ?? false;
                          });
                        },
                      ),
                      subtitle: isEnabled
                          ? const Text('Blog is enabled on website')
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Categories (comma separated)',
                  hintText: 'Article Categories',
                  prefixIcon: Icons.category_outlined,
                  controller: tagsController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Author Article',
                  hintText: 'Name of the Author Article',
                  prefixIcon: Icons.person_2_outlined,
                  controller: authorController,
                ),
                const SizedBox(height: 20),

                HtmlEditor(
                  controller: controller,
                  htmlEditorOptions: const HtmlEditorOptions(
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
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateController,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDateController) {
        setState(() {
          selectedDateController = picked;
          newdateController.text =
              "${selectedDateController.toLocal()}".split(' ')[0];
        });
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
