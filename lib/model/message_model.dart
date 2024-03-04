class Message {
  final String messageId, senderId, semester, email, phoneNo;
  final String collegeName, branchName, message, senderName, dateTime;

  Message({
    required this.messageId,
    required this.senderId,
    required this.semester,
    required this.collegeName,
    required this.branchName,
    required this.message,
    required this.senderName,
    required this.dateTime,
    required this.email,
    required this.phoneNo,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        messageId: json['messageId'],
        senderId: json['senderId'],
        message: json['message'],
        dateTime: json['timeStamp'],
        collegeName: json['college_name'],
        branchName: json['branch'],
        semester: json['semester'],
        senderName: json['name'],
        email: json['email'],
        phoneNo: json['phone_no'],

        //* Receiving data format
        // "messageId": "1",
        // "senderId": "1",
        // "message": "This text is sent from Terna college of Engineering.",
        // "timeStamp": "2024-01-21 22:11:12",
        // "college_name": "Terna Engineering College (TEC)",
        // "branch": "Computer Science Engineering",
        // "semester": "6",
        // "name": "Ahmad Ali",
        // "email": "aali.dev7@gmail.com",
        // "phone_no": "8097746607
      );
}
