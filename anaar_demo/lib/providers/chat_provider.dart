// import 'dart:convert';
// import 'package:anaar_demo/helperfunction/helperfunction.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class ChatProvider with ChangeNotifier {
//   List<String> _chatUserIds = [];
//   List<String> get chatUserIds => _chatUserIds;
//   List<Map<String, dynamic>> _messages = [];
//   List<Map<String, dynamic>> get messages => _messages;

//   late IO.Socket _socket;
//   late String? _currentUserId;

//   ChatProvider() {
//     _initSocket();
//   }

//   Future<void> _initSocket() async {
//     _currentUserId = await Helperfunction
//         .getUserId(); // Replace with your method to get user ID

//     _socket = IO.io('http://192.168.0.107:3000/', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });

//     _socket.connect();

//     _socket.on('connect', (_) {
//       print('Connected to socket server');
//       _socket.emit('register', {'userId': _currentUserId});
//     });

//     _socket.on('disconnect', (_) => print('Disconnected from socket server'));

//     _socket.on('message', (data) {
//       print('Received message: $data');
//       _messages.add(data);
//       notifyListeners();
//     });

//     // Fetch chat user IDs
//     fetchChatUserIds();
//   }

//   Future<void> fetchChatUserIds() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://192.168.0.107:3000/api/chats/$_currentUserId'),
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body);
//         _chatUserIds = List<String>.from(jsonData);
//         notifyListeners();
//       } else {
//         throw Exception('Failed to fetch chat user IDs');
//       }
//     } catch (error) {
//       print('Error fetching chat user IDs: $error');
//       throw error;
//     }
//   }

//   void sendMessage(String? recipientId, String messageContent) {
//     final data = {
//       'userId1': _currentUserId,
//       'userId2': recipientId,
//       'message': messageContent,
//     };
//     _socket.emit('sendMessage', data);
//   }

//   void dispose() {
//     _socket.disconnect();
//     super.dispose();
//   }
// }



// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// class ChatMessage {
//   final String userId;
//   final String message;

//   ChatMessage({required this.userId, required this.message});
// }

// class ChatProvider with ChangeNotifier {
//   List<ChatMessage> _messages = [];
//   List<ChatMessage> get messages => _messages;

//   Future<void> initializeChat(String userId1, String userId2) async {
//      final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');
//     // Call your backend API to get or create a chat
//     final response = await http.post(
//       Uri.parse('https://shopemeapp-backend.onrender.com/api/chat/addChat'),
//       body: json.encode({'userId1': userId1, 'userId2': userId2}),
//       headers: {'Content-Type': 'application/json',
//        'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       final chatData = json.decode(response.body);
//       _messages = chatData['messages']
//           .map<ChatMessage>((msg) => ChatMessage(userId: msg['userId'], message: msg['message']))
//           .toList();
//       notifyListeners();
//     } else {
//       throw Exception('Failed to initialize chat');
//     }
//   }

//   Future<void> sendMessage(String userId1, String userId2, String message) async {
//     // Call your backend API to send a message
//      final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');
//     final response = await http.post(
//       Uri.parse('https://shopemeapp-backend.onrender.com/api/chat/updateChat'),
//       body: json.encode({'userId1': userId1, 'userId2': userId2, 'message': message}),
//       headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token',},
//     );

//     if (response.statusCode == 200) {
//       _messages.add(ChatMessage(userId: userId1, message: message));
//       notifyListeners();
//     } else {
//      print("${response.statusCode}.................failed .........${response.body }");
//     }
//   }
// }


import 'dart:async';

import 'package:anaar_demo/backend/notification_services.dart';
import 'package:anaar_demo/model/chat_message_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';

@HiveType(typeId: 0)
class ChatMessage {
   @HiveField(0)
  final String userId;
  @HiveField(1)
  final String message;
  

  ChatMessage({required this.userId, required this.message});
}
// class ChatPreview {
//   final String chatId;
//   final String otherUserId;
//   final String otherUserName;
//   String? image;
//   final String lastMessage;
//   final DateTime timestamp;

//   ChatPreview({
//     this.image,
//     required this.chatId,
//     required this.otherUserId,
//     required this.otherUserName,
//     required this.lastMessage,
//     required this.timestamp,
//   });
// }




// class ChatProvider with ChangeNotifier {
//   List<ChatMessage> _messages = [];
//   List<ChatMessage> get messages => _messages;

//   late IO.Socket socket;
//   String? _currentChatId;
//   final NotificationService _notificationService = NotificationService();

//   // Constructor to initialize socket and notifications
//   ChatProvider() {
//    NotificationService.initNotification;
//     initSocket();
//   }

//   // Initialize the Socket.IO connection
//   void initSocket() {
//     socket = IO.io('https://shopemeapp-backend.onrender.com', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });

//     socket.connect().on('connect_error', (err) => print('Socket error: $err'));
//     print('Socket initialized and connected');

//     // Listen for 'new message' event
//     socket.on('new message', (data) {
//       print('Received new message: ${data['message']}');

//       // Add the new message to the messages list
//       _messages.add(ChatMessage(
//         userId: data['userId'],
//         message: data['message'],
//       ));

//       // Notify listeners to update the UI
//       notifyListeners();
// print("newwwwwwww message aya.....................................................................................");
// //Show a notification if the current chat is not active
//       if (_currentChatId != data['chatId']) {
//         NotificationService.showNotification(
//           id: data['chatId'].hashCode, // Unique ID based on chat ID
//           title: 'New message from ${data['userName']}',
//           body: data['message'],
//           payload: data['chatId'], // Pass chat ID as payload
//         );
//       }
//     });
//   }

//   // Initialize a chat between two users
//   Future<void> initializeChat(String? userId1, String userId2) async {
//     print('Initializing chat for users $userId1 and $userId2');
//     final response = await http.post(
//       Uri.parse('https://shopemeapp-backend.onrender.com/api/chat/addChat'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({'userId1': userId1, 'userId2': userId2}),
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final chatData = json.decode(response.body);
//       _currentChatId = chatData['_id'];

//       // Load existing messages
//       _messages = chatData['messages']
//           .map<ChatMessage>((msg) => ChatMessage(
//                 userId: msg['userId'],
//                 message: msg['message'],
//               ))
//           .toList();

//       // Join the chat room on the socket
//       socket.emit('join chat', _currentChatId);
//       print('Chat initialized with ID: $_currentChatId');
//       notifyListeners();
//     } else {
//       print(
//           'Failed to initialize chat. Status code: ${response.statusCode} ${response.body}');
//       throw Exception('Failed to initialize chat');
//     }
//   }

//   // Send a message
//   void sendMessage(String? userId, String message) {
//     if (_currentChatId != null) {
//       print("Sending message from user $userId: $message");

//       socket.emit('send message', {
//         'chatId': _currentChatId,
//         'userId': userId,
//         'message': message,
//       });
//     } else {
//       print('Cannot send message: Chat not initialized');
//     }
//   }

//   // Get chat previews for the logged-in user
//   Future<List<ChatPreview>> getChatPreviews(String? loggedInUserId) async {
//     try {
//       print("Fetching chat previews for user $loggedInUserId");
//       final response = await http.get(
//         Uri.parse(
//             'https://shopemeapp-backend.onrender.com/api/chat/ChatPreview?id=$loggedInUserId'),
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         print("Successfully fetched chat previews");
//         return data.map((json) => ChatPreview.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load chat previews: ${response.body}');
//       }
//     } catch (e) {
//       print('Error getting chat previews: $e');
//       throw Exception('Failed to load chat previews: $e');
//     }
//   }

//   // Mark messages as read
//   Future<void> markMessagesAsRead(String chatId, String userId) async {
//     try {
//       print("Marking messages as read for chat $chatId");
//       final response = await http.post(
//         Uri.parse('https://shopemeapp-backend.onrender.com/api/chat/Markasread'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({'chatId': chatId, 'userId': userId}),
//       );

//       if (response.statusCode == 200) {
//         print("Messages marked as read successfully");
//         notifyListeners();
//       } else {
//         throw Exception(
//             'Failed to mark messages as read: ${response.statusCode} ${response.body}');
//       }
//     } catch (error) {
//       print('Error marking messages as read: $error');
//       throw error;
//     }
//   }

//   // Dispose method to clean up resources
//   @override
//   void dispose() {
//     print('Disposing ChatProvider');
//     socket.disconnect();
//     super.dispose();
//   }
// }


class ChatProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  final StreamController<List<ChatMessage>> _messageStreamController = StreamController.broadcast();
  Stream<List<ChatMessage>> get messageStream => _messageStreamController.stream;

  late IO.Socket socket;
  String? _currentChatId;
  final NotificationService _notificationService = NotificationService();

  ChatProvider() {
    NotificationService.initNotification;
    initSocket();
  }

  void initSocket() {
    socket = IO.io('https://shopemeapp-backend.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect().on('connect_error', (err) => print('Socket error: $err'));
    print('Socket initialized and connected');

    // Ensure the listener is not attached multiple times
    socket.off('new message');
    socket.on('new message', (data) {
      print('Received new message: ${data['message']}');

      // Deduplication check - avoid adding the same message multiple times
      bool alreadyExists = _messages.any((msg) => msg.message == data['message'] && msg.userId == data['userId']);
    
      if (!alreadyExists) {
        _messages.add(ChatMessage(
          userId: data['userId'],
          message: data['message'],
        ));

        _messageStreamController.add(_messages);
        notifyListeners();

        // Show a notification if the current chat is not active
        if (_currentChatId != data['_id']) {
          NotificationService.showNotification(
            id: data['chatId'].hashCode,
            title: 'New message from ${data['userName']}',
            body: data['message'],
            payload: data['chatId'],
          );
        }
      } else {
        print('Duplicate message detected, skipping addition.');
      }
    });
  }

  Future<void> initializeChat(String? userId1, String userId2) async {
    print('Initializing chat for users $userId1 and $userId2');
    final response = await http.post(
      Uri.parse('https://shopemeapp-backend.onrender.com/api/chat/addChat'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId1': userId1, 'userId2': userId2}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final chatData = json.decode(response.body);
      _currentChatId = chatData['_id'];

      _messages = chatData['messages']
          .map<ChatMessage>((msg) => ChatMessage(
                userId: msg['userId'],
                message: msg['message'],
              ))
          .toList();


      _messageStreamController.add(_messages);
      socket.emit('join chat', _currentChatId);
      print('Chat initialized with ID: $_currentChatId');
      notifyListeners();
    } else {
      print(
          'Failed to initialize chat. Status code: ${response.statusCode} ${response.body}');
      throw Exception('Failed to initialize chat');
    }
  }

  void sendMessage(String? userId, String message) {
    if (_currentChatId != null) {
      print("Sending message from user $userId: $message");
 // Optimistically add the message to the list

       final chatMessage = ChatMessage(
            userId: userId!,
            message: message,
        );
        _messages.add(chatMessage);
        _messageStreamController.add(_messages);
        notifyListeners();
// Send the message to the server
      socket.emit('send message', {
        'chatId': _currentChatId,
        'userId': userId,
        'message': message,
      });

//.............add message directly to the steram .............when user is in the screen..








    } else {
      print('Cannot send message: Chat not initialized');
    }
  }

  Future<List<ChatPreview>> getChatPreviews(String? loggedInUserId) async {
    try {
      print("Fetching chat previews for user $loggedInUserId");
      final response = await http.get(
        Uri.parse(
            'https://shopemeapp-backend.onrender.com/api/chat/ChatPreview?id=$loggedInUserId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print("Successfully fetched chat previews");
        return data.map((json) => ChatPreview.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load chat previews: ${response.body}');
      }
    } catch (e) {
      print('Error getting chat previews: $e');
      throw Exception('Failed to load chat previews: $e');
    }
  }

  Future<void> markMessagesAsRead(String chatId, String userId) async {
    try {
      print("Marking messages as read for chat $chatId");
      final response = await http.post(
        Uri.parse('https://shopemeapp-backend.onrender.com/api/chat/Markasread'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'chatId': chatId, 'userId': userId}),
      );

      if (response.statusCode == 200) {
        print("Messages marked as read successfully");
        notifyListeners();
      } else {
        throw Exception(
            'Failed to mark messages as read: ${response.statusCode} ${response.body}');
      }
    } catch (error) {
      print('Error marking messages as read: $error');
      throw error;
    }
  }

  @override
  void dispose() {
    print('Disposing ChatProvider');
    socket.disconnect();
    _messageStreamController.close();
    super.dispose();
  }
}
