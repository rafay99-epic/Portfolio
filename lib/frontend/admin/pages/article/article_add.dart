// ignore_for_file: use_build_context_synchronously

import 'dart:html' as html;
import 'package:flutter/material.dart';

import 'package:html_editor_enhanced/html_editor.dart';
import 'package:rafay_portfolio/backend/article_functionality/article_functionality.dart';
import 'package:rafay_portfolio/constants/widgets/dialogBox/dialogbox.dart';
import 'package:rafay_portfolio/constants/widgets/text/textstyle.dart';
import 'package:rafay_portfolio/constants/widgets/textfeild/buildTextField.dart';
import 'package:rafay_portfolio/frontend/admin/pages/article/article_preview.dart';

class AddBlogPost extends StatefulWidget {
  const AddBlogPost({Key? key}) : super(key: key);

  @override
  State<AddBlogPost> createState() => _AddBlogPostState();
}

class _AddBlogPostState extends State<AddBlogPost> {
  // --------------------------
  // Controllers and Variables
  // --------------------------

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final subTitleController = TextEditingController();
  final tagsController = TextEditingController();
  final authorController = TextEditingController();
  final dateController = TextEditingController();
  DateTime selectedDateController = DateTime.now();
  HtmlEditorController controller = HtmlEditorController();
  final urlController = TextEditingController();
  final ArticleFunctionality articleFunctionality = ArticleFunctionality();
  bool isEnabled = false;
  html.File? _image;
  final scrollController = ScrollController();
  String? _imageUrl;

  // --------------------------
  // Init & Dispoase Functions
  // --------------------------
  @override
  void dispose() {
    titleController.dispose();
    subTitleController.dispose();
    tagsController.dispose();
    authorController.dispose();
    dateController.dispose();
    _image = null;
    _imageUrl = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    try {
      dateController.text = "${selectedDateController.toLocal()}".split(' ')[0];
    } catch (e) {
      showDialogBox(
        context,
        Icons.error,
        Colors.red,
        Colors.red,
        'Error',
        'Sorrry Error while setting date. Please try again.',
        () => Navigator.of(context).pop(),
      );
    }
  }

  // --------------------------
  // Main Running Widget
  // --------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(),
    );
  }

  // --------------------------
  // App Bar of the Widget
  // --------------------------
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: StyledText(
        text: 'Add Article',
        fontSize: 22,
        color: Theme.of(context).colorScheme.primary,
        textAlign: TextAlign.left,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      actions: <Widget>[
        const SizedBox(width: 15),
        // --------------------------
        // Preview Blog Button
        // --------------------------
        buildPreviewButton(context),
        const SizedBox(width: 15),
        // --------------------------
        // Save Blog Button
        // --------------------------
        buildSaveButton(),
        const SizedBox(width: 15),
      ],
    );
  }

  // --------------------------
  // Preview Blog Function
  // --------------------------
  TextButton buildPreviewButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
      ),
      onPressed: () async {
        final text = await controller.getText();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogPreview(
              title: titleController.text,
              subTitle: subTitleController.text,
              tags: tagsController.text,
              author: authorController.text,
              date: dateController.text,
              selectedDate: selectedDateController,
              htmlData: text,
              image: _image,
            ),
          ),
        );
      },
      child: const Text('Preview Article'),
    );
  }

  // --------------------------
  // Save Blog Function
  // --------------------------
  TextButton buildSaveButton() {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          try {
            await articleFunctionality.addBlogPost(
              title: titleController.text,
              subTitle: subTitleController.text,
              isEnabled: isEnabled,
              tags: tagsController.text.split(','),
              author: authorController.text,
              content: await controller.getText(),
              imageFile: _image!,
              date: selectedDateController,
              url: urlController.text,
            );
            // --------------------------
            // Clear All Form
            // --------------------------
            clearForm();
            // --------------------------
            // Dialog Box
            // --------------------------
            showDialog(
              context: context,
              builder: (context) => buildDialog(
                  'Blog Added', 'The blog post has been successfully added.'),
            );
          } catch (e) {
            showDialog(
              context: context,
              builder: (context) => buildDialog('Error', e.toString()),
            );
          }
        }
      },
      child: const Text('Save Blog Post'),
    );
  }

  // ---------------------------------------
  // Alert Box for Showing Casing Messages
  // ---------------------------------------
  AlertDialog buildDialog(String title, String content) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  // --------------------------
  // Clear Form Function
  // --------------------------
  void clearForm() {
    titleController.clear();
    subTitleController.clear();
    tagsController.clear();
    authorController.clear();
    urlController.clear();
    isEnabled = false;
    controller.clear();
    _image = null;
    _imageUrl = null;
  }

  // --------------------------
  // Body of the Widget
  // --------------------------
  Form buildBody() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          buildTextField(
            'Article Title',
            'Enter Article Title',
            Icons.title,
            titleController,
          ),
          const SizedBox(height: 20),
          buildTextField(
            'Article Description',
            'Article Description',
            Icons.description,
            subTitleController,
          ),
          const SizedBox(height: 20),
          buildImageUpload(),
          const SizedBox(height: 20),
          buildDateSelector(),
          const SizedBox(height: 20),
          buildEnabledCheckbox(),
          const SizedBox(height: 20),
          buildTextField('Categories (comma separated)', 'Article Categories',
              Icons.category_outlined, tagsController),
          const SizedBox(height: 20),
          buildTextField('Author Article', 'Name of the Author Article',
              Icons.person_2_outlined, authorController),
          const SizedBox(height: 20),
          buildTextField('Website URL', 'Website URL of the Article',
              Icons.share, urlController),
          const SizedBox(height: 20),
          buildHtmlEditor(),
        ],
      ),
    );
  }

  // --------------------------
  // text Feild
  // --------------------------
  CustomTextField buildTextField(String labelText, String hintText,
      IconData prefixIcon, TextEditingController controller) {
    return CustomTextField(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      controller: controller,
    );
  }

  // --------------------------
  // Image Update
  // --------------------------
  Column buildImageUpload() {
    return Column(
      children: [
        buildUploadButton(),
        const SizedBox(height: 15),
        if (_imageUrl != null) buildImagePreview(),
      ],
    );
  }

  // --------------------------
  // Upload Image Button
  // --------------------------
  Padding buildUploadButton() {
    return Padding(
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
    );
  }

  // --------------------------
  // Image Preview
  // --------------------------
  Container buildImagePreview() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          _imageUrl!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // --------------------------
  // Selete Date & Time
  // --------------------------
  Padding buildDateSelector() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: ElevatedButton(
        onPressed: () => _selectDate(context),
        child: const Text('Select date'),
      ),
    );
  }

  // --------------------------
  // Enable and Disable Blog
  // --------------------------
  Padding buildEnabledCheckbox() {
    return Padding(
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
          subtitle: isEnabled ? const Text('Blog is enabled on website') : null,
        ),
      ),
    );
  }

  // --------------------------
  // HTML Editior
  // --------------------------
  HtmlEditor buildHtmlEditor() {
    return HtmlEditor(
      controller: controller,
      htmlEditorOptions: const HtmlEditorOptions(
        hint: "Write your Blog here...",
        autoAdjustHeight: true,
        spellCheck: true,
        darkMode: false,
      ),
    );
  }

  // --------------------------
  // Fetch Current Date
  // --------------------------
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
