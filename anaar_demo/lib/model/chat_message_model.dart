// class ChatMessage {
//   final String id;
//   final String senderId;
//   final String? receiverId;
//   final String content;
//   final DateTime timestamp;

//   ChatMessage({
//     required this.id,
//     required this.senderId,
//     this.receiverId,
//     required this.content,
//     required this.timestamp,
//   });

//   factory ChatMessage.fromJson(Map<String, dynamic> json) {
//     return ChatMessage(
//       id: json['_id'],
//       senderId: json['senderId'],
//       receiverId: json['receiverId'],
//       content: json['content'],
//       timestamp: DateTime.parse(json['timestamp']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'senderId': senderId,
//       'receiverId': receiverId,
//       'content': content,
//       'timestamp': timestamp.toIso8601String(),
//     };
//   }
// }

class Message {
  final String senderId;
  final String recipientId;
  final String content;
  final DateTime timestamp;

  Message({
    required this.senderId,
    required this.recipientId,
    required this.content,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      recipientId: json['recipientId'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'recipientId': recipientId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}



class Chat {
  final List<String> participants;
  Message lastMessage;

  Chat({required this.participants, required this.lastMessage});
}