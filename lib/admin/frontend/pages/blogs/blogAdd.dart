// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, avoid_web_libraries_in_flutter, file_names

// import 'dart:html' as html;
import 'package:flutter/material.dart';

import 'package:html_editor_enhanced/html_editor.dart';
import 'package:rafay_portfolio/admin/backend/blog/blogAdd.dart';
import 'package:rafay_portfolio/admin/frontend/pages/blogs/blog_preview.dart';
import 'package:rafay_portfolio/user/frontend/widgets/buildTextField.dart';
import 'package:rafay_portfolio/user/frontend/widgets/textstyle.dart';
import 'package:flutter_html/flutter_html.dart';

class AddBlogPost extends StatefulWidget {
  const AddBlogPost({Key? key}) : super(key: key);

  @override
  State<AddBlogPost> createState() => _AddBlogPostState();
}

class _AddBlogPostState extends State<AddBlogPost> {
  //controllers
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final subTitleController = TextEditingController();
  final tagsController = TextEditingController();
  final authorController = TextEditingController();
  final dateController = TextEditingController();
  DateTime selectedDateController = DateTime.now();
  HtmlEditorController controller = HtmlEditorController();

  bool isEnabled = false;
  // html.File? _image;
  final scrollController = ScrollController();

  String? _imageUrl;
  String? _previewHtml;
  //dispose controllers
  @override
  void dispose() {
    titleController.dispose();
    subTitleController.dispose();
    tagsController.dispose();
    authorController.dispose();
    dateController.dispose();

    super.dispose();
  }

  //initial some controller
  @override
  void initState() {
    super.initState();
    try {
      dateController.text = "${selectedDateController.toLocal()}".split(' ')[0];
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledText(
          text: 'Add Article',
          fontSize: 22,
          color: Theme.of(context).colorScheme.primary,
          textAlign: TextAlign.left,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.background,
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    shape: RoundedRectangleBorder(
                      // Rounded corners
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                  ),
                  onPressed: () async {
                    //render whole Article
                    final text = await controller.getText();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => BlogPreview(
                    //       title: titleController.text,
                    //       subTitle: subTitleController.text,
                    //       tags: tagsController.text,
                    //       author: authorController.text,
                    //       date: dateController.text,
                    //       selectedDate: selectedDateController,
                    //       htmlData: text,
                    //       image: _image,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Text('Preview Article'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.background,
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    shape: RoundedRectangleBorder(
                      // Rounded corners
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                  ),
                  onPressed: () async {
                    final text = await controller.getText();
                    setState(() {
                      _previewHtml = text;
                    });

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Theme.of(context).colorScheme.background,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Scrollbar(
                            controller: scrollController,
                            child: SingleChildScrollView(
                              controller: scrollController,
                              padding: EdgeInsets.all(10),
                              child: Html(data: _previewHtml),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text('Preview Article Content'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.background,
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    shape: RoundedRectangleBorder(
                      // Rounded corners
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        // await addBlogPost(
                        //   title: titleController.text,
                        //   subTitle: subTitleController.text,
                        //   isEnabled: isEnabled,
                        //   tags: tagsController.text.split(','),
                        //   author: authorController.text,
                        //   content: await controller.getText(),
                        //   imageFile: _image!,
                        //   date: selectedDateController,
                        // );

                        titleController.clear();
                        subTitleController.clear();
                        tagsController.clear();
                        authorController.clear();
                        isEnabled = false;
                        controller.clear();

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Blog Added'),
                            content: Text(
                                'The blog post has been successfully added.'),
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
                      // html.FileUploadInputElement uploadInput =
                      //     html.FileUploadInputElement();
                      // uploadInput.click();

                      // uploadInput.onChange.listen((e) {
                      //   final files = uploadInput.files;
                      //   if (files!.length == 1) {
                      //     final file = files[0];
                      //     final reader = html.FileReader();
                      //     reader.readAsDataUrl(file);
                      //     reader.onLoadEnd.listen((event) {
                      //       setState(() {
                      //         _image = file;
                      //         _imageUrl = reader.result as String;
                      //       });
                      //     });
                      //   }
                      // });
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
                  subtitle:
                      isEnabled ? Text('Blog is enabled on website') : null,
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

  //fetch date
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
          dateController.text =
              "${selectedDateController.toLocal()}".split(' ')[0];
        });
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
