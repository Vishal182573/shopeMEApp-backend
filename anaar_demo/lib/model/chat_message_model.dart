class ChatPreview {
  final String chatId;
  final String otherUserId;
  final String otherUserName;
  final String lastMessage;
  final String timestamp;
  final String image;
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
     unreadCount: json['unreadCount']?? 0,

    );
  }
}