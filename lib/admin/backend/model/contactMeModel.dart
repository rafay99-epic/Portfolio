class ContactMessage {
  final String name;
  final String email;
  final String message;
  final bool hideMessage;

  ContactMessage({
    required this.name,
    required this.email,
    required this.message,
    this.hideMessage = false,
  });

  factory ContactMessage.fromMap(Map<String, dynamic> map) {
    return ContactMessage(
      name: map['name'],
      email: map['email'],
      message: map['message'],
      hideMessage: map['hideMessage'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'message': message,
      'hideMessage': hideMessage,
    };
  }
}
