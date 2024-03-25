class contact_message {
  final String name;
  final String email;
  final String message;
  final bool hideMessage;

  contact_message({
    required this.name,
    required this.email,
    required this.message,
    this.hideMessage = false,
  });

  factory contact_message.fromMap(Map<String, dynamic> map) {
    return contact_message(
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
