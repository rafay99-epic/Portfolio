import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rafay_portfolio/admin/backend/model/contactMeModel.dart';

CollectionReference messages =
    FirebaseFirestore.instance.collection('messages');

Future<void> saveContactMessage(ContactMessage message) async {
  await messages.add(message.toMap());
}
