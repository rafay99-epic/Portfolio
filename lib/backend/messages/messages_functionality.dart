import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rafay_portfolio/backend/model/message_model.dart';

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

  Future<void> saveContactMessage(ContactMessage message) async {
    try {
      await messages.add(message.toMap());
    } catch (e) {
      rethrow;
    }
  }

  //delete Message:
  Future<void> deleteMessage(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(docId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  //unhide Message:

  Future<void> unhideMessage(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(docId)
          .update({
        'hideMessage': false,
      });
    } catch (e) {
      rethrow;
    }
  }
}
