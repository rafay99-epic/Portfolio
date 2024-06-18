// ignore_for_file: use_build_context_synchronously, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rafay_portfolio/backend/messages/messages_functionality.dart';
import 'package:rafay_portfolio/constants/widgets/dialogBox/dialogbox.dart';
import 'package:rafay_portfolio/constants/widgets/errorAndLanding/error.dart';
import 'package:rafay_portfolio/constants/widgets/errorAndLanding/loading.dart';
import 'package:rafay_portfolio/constants/widgets/ultis/admin_drawer.dart';

class InboxMessages extends StatefulWidget {
  const InboxMessages({super.key});

  @override
  State<InboxMessages> createState() => _InboxMessagesState();
}

class _InboxMessagesState extends State<InboxMessages> {
  final MessageService messageService = MessageService();
  final Stream<QuerySnapshot> _messagesStream =
      FirebaseFirestore.instance.collection('messages').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const MyDrawerAdmin(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          "Inbox Messages",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _messagesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return buildErrorWidget(context);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildLoadingIndicator(context);
          }
          return SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.where((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                return data['hideMessage'] == false;
              }).map(
                (DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return Card(
                    color: Theme.of(context).colorScheme.primary,
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.message,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      title: Text(data['name'] ?? 'No name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.surface,
                          )),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['email'] ?? 'No email',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 87, 188, 238),
                              )),
                          const SizedBox(height: 5.0),
                          Text(
                            data['message'] ?? 'No message',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.archive,
                              color: Colors.green,
                            ),
                            onPressed: () async {
                              await messageService.hideMessage(document.id);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Delete Message',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                    ),
                                    content: Text(
                                      'Do you want to Delete this Message?',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
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
                                            foregroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          child: const Text(
                                            'No',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                          ),
                                          child: const Text(
                                            'Yes',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () async {
                                            try {
                                              await messageService
                                                  .deleteMessage(document.id);
                                              Navigator.pop(context);
                                            } catch (e) {
                                              showDialogBox(
                                                context,
                                                Icons.error,
                                                Colors.red,
                                                Colors.red,
                                                'Error',
                                                e.toString(),
                                                () =>
                                                    Navigator.of(context).pop(),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          );
        },
      ),
    );
  }
}
