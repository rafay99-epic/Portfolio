import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:rafay_portfolio/frontend/widgets/FeatureNotAvailableButton.dart';
import 'package:rafay_portfolio/frontend/widgets/animatedtext.dart';
import 'package:rafay_portfolio/frontend/widgets/buildTextField.dart';
import 'package:rafay_portfolio/frontend/widgets/textstyle.dart';

class ContactMe extends StatefulWidget {
  const ContactMe({Key? key}) : super(key: key);

  @override
  State<ContactMe> createState() => _ContactMeState();
}

final nameController = TextEditingController();
final emailController = TextEditingController();
final messageController = TextEditingController();

class _ContactMeState extends State<ContactMe> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 55.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AnimatedTextBuilder(
                          text: "Contact Me",
                          size: 70.0,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const StyledText(
                          text:
                              "I'm available for freelance work. Feel free to reach out!",
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
                          onPressed: () {
                            //firebase store data
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const FeatureNotAvailableButton();
                              },
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
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
                ),
                Expanded(
                  child: Lottie.asset(
                    'assets/animation/contact.json',
                    height: 500,
                    width: 500,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
