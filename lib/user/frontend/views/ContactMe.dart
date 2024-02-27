// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:rafay_portfolio/admin/backend/messages/message.dart';
import 'package:rafay_portfolio/admin/backend/model/contactMe.dart';
import 'package:rafay_portfolio/user/frontend/widgets/animatedtext.dart';
import 'package:rafay_portfolio/user/frontend/widgets/buildTextField.dart';
import 'package:rafay_portfolio/user/frontend/widgets/textstyle.dart';

class ContactMe extends StatefulWidget {
  const ContactMe({Key? key}) : super(key: key);

  @override
  State<ContactMe> createState() => _ContactMeState();
}

final _formKey = GlobalKey<FormState>();
final nameController = TextEditingController();
final emailController = TextEditingController();
final messageController = TextEditingController();

class _ContactMeState extends State<ContactMe> {
  @override
  Widget build(BuildContext context) {
    bool isMobile =
        MediaQuery.of(context).size.width < 600; // Adjust the value as needed

    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(5.0),
            child: isMobile
                ? _buildMobileLayout(isMobile)
                : _buildWebLayout(isMobile),
          ),
        )
      ],
    );
  }

  Widget _buildMobileLayout(bool isMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildChildren(isMobile),
    );
  }

  Widget _buildWebLayout(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildChildren(isMobile),
    );
  }

  List<Widget> _buildChildren(bool isMobile) {
    return [
      Expanded(
        child: _buildForm(isMobile),
      ),
      if (!isMobile)
        Expanded(
          child: Lottie.asset(
            'assets/animation/contact.json',
            height: 500,
            width: 500,
          ),
        ),
    ];
  }

  Widget _buildForm(bool isMobile) {
    return Padding(
      padding: isMobile
          ? const EdgeInsets.all(12)
          : const EdgeInsets.only(left: 55.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedTextBuilder(
              text: "Contact Me",
              size: isMobile ? 40.0 : 72.0,
            ),
            const SizedBox(
              height: 15.0,
            ),
            const StyledText(
              text: "I'm available for freelance work. Feel free to reach out!",
              fontSize: 20.0,
              bold: true,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              labelText: 'Name',
              controller: nameController,
              hintText: 'Enter your name',
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: Icons.email,
              controller: emailController,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              labelText: 'Message',
              controller: messageController,
              maxLines: 5,
              hintText: 'Enter your message',
              prefixIcon: Icons.message,
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextButton.icon(
              onPressed: () async {
                // checking for empty fields
                if (nameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    messageController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            const Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Error',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        content: const Text(
                          'Please provide all the information. Thank you!',
                        ),
                        actions: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  if (_formKey.currentState!.validate()) {
                    ContactMessage message = ContactMessage(
                      name: nameController.text,
                      email: emailController.text,
                      message: messageController.text,
                    );
                    try {
                      await saveContactMessage(message);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Success',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                            content: Text(
                              'Message sent. Thank you for contacting me.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 22,
                              ),
                            ),
                            actions: <Widget>[
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                  ),
                                  onPressed: () {
                                    nameController.clear();
                                    emailController.clear();
                                    messageController.clear();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Row(
                              children: [
                                const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Error',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                            content: Text('Failed to send message: $e'),
                            actions: <Widget>[
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                padding: const EdgeInsets.all(20.0),
              ),
              label: const Text("Submit Message"),
              icon: const Icon(Icons.send_rounded),
            ),
          ],
        ),
      ),
    );
  }

  // check for empty fields
  void checkControllers(BuildContext context) {}
}
