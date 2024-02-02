import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rafay_portfolio/frontend/widgets/FeatureNotAvailableButton.dart';
import 'package:rafay_portfolio/frontend/widgets/buildTextField.dart';

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
                        Text(
                          "Contact Me",
                          style: TextStyle(
                            fontSize: 70.0,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "I'm available for freelance work. Feel free to reach out!",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
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
                        TextButton(
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
                            padding: const EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Text(
                            "Send Message",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
