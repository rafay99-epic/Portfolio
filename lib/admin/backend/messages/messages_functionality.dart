import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rafay_portfolio/admin/backend/model/message_model.dart';

class MessageService {
  //Hide Message
  Future<void> hideMessage(String docId) async {
    await FirebaseFirestore.instance.collection('messages').doc(docId).update({
      'hideMessage': true,
    });
  }

  //Save Message
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  Future<void> saveContactMessage(contact_message message) async {
    await messages.add(message.toMap());
  }

  //delete Message:
  Future<void> deleteMessage(String docId) async {
    await FirebaseFirestore.instance.collection('messages').doc(docId).delete();
  }

  //unhide Message:

  Future<void> unhideMessage(String docId) async {
    await FirebaseFirestore.instance.collection('messages').doc(docId).update({
      'hideMessage': false,
    });
  }
}
