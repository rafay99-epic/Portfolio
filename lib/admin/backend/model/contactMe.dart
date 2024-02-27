// ignore: file_names
class ContactMessage {
  final String name;
  final String email;
  final String message;

  ContactMessage(
      {required this.name, required this.email, required this.message});

  // Method to make ContactMessage from Map (useful for Firestore)
  factory ContactMessage.fromMap(Map<String, dynamic> map) {
    return ContactMessage(
      name: map['name'],
      email: map['email'],
      message: map['message'],
    );
  }

  // Method to convert ContactMessage to Map (useful for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'message': message,
    };
  }
}
