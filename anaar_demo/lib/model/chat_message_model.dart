import 'package:hive/hive.dart';


@HiveType(typeId: 1) // Assign a unique typeId
class ChatPreview {
  @HiveField(0)
  final String chatId;

  @HiveField(1)
  final String otherUserId;

  @HiveField(2)
  final String otherUserName;

  @HiveField(3)
  final String lastMessage;

  @HiveField(4)
  final String timestamp;

  @HiveField(5)
  final String image;

  @HiveField(6)
  final int unreadCount;

  ChatPreview({
    required this.chatId,
    required this.otherUserId,
    required this.otherUserName,
    required this.lastMessage,
    required this.timestamp,
    required this.image,
    required this.unreadCount,
  });

  factory ChatPreview.fromJson(Map<String, dynamic> json) {
    return ChatPreview(
      chatId: json['chatId'] ?? '',
      otherUserId: json['otherUserId'] ?? '',
      otherUserName: json['otherUserName'] ?? 'Unknown',
      lastMessage: json['lastMessage'] ?? '',
      timestamp: json['timestamp'] ?? '',
      image: json['image'] ?? '',
      unreadCount: json['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'otherUserId': otherUserId,
      'otherUserName': otherUserName,
      'lastMessage': lastMessage,
      'timestamp': timestamp,
      'image': image,
      'unreadCount': unreadCount,
    };
  }
}
