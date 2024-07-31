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


import 'package:anaar_demo/model/chat_message_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';

class ChatMessage {
  final String userId;
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


class ChatProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;
  late IO.Socket socket;
  String? _currentChatId;

  void initSocket() {
    socket = IO.io('https://shopemeapp-backend.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect().onerror((err)=>print(err));
    print('Socket initialized and connected');
   
    socket.on('new message', (data) {
      print('Received new message: ${data['message']}');
      _messages.add(ChatMessage(userId: data['userId'], message: data['message']));
      notifyListeners();
    });
  }

  Future<void> initializeChat(String? userId1, String userId2) async {
    print('Initializing chat for users $userId1 and $userId2');
    final response = await http.post(
      Uri.parse('https://shopemeapp-backend.onrender.com/api/chat/addChat'),
      body: json.encode({'userId1': userId1, 'userId2': userId2}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final chatData = json.decode(response.body);
      _currentChatId = chatData['_id'];
      _messages = chatData['messages']
          .map<ChatMessage>((msg) => ChatMessage(userId: msg['userId'], message: msg['message']))
          .toList();
      socket.emit('join chat', _currentChatId);
      print('Chat initialized with ID: $_currentChatId');
      notifyListeners();
    } else {
      print('Failed to initialize chat. Status code: ${response.statusCode}${response.body}');
      throw Exception('Failed to initialize chat');
    }
  }

  void sendMessage(String? userId, String message) {
    if (_currentChatId != null) {
      print("............................${userId}");
      print('Sending message:....... $message');
      socket.emit('send message', {
        'chatId': _currentChatId,
        'userId': userId,
        'message': message,
      });
    } else {
      print('Cannot send message: Chat not initialized');
    }
  }

Future<List<ChatPreview>> getChatPreviews(String? loggedInUserId) async {
    try {
      final response = await http.get(Uri.parse('https://shopemeapp-backend.onrender.com/api/chat/ChatPreview?id=$loggedInUserId'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(response.body);
        print(".............................................got message tiles......................successfully");
     return  data.map((json) => ChatPreview.fromJson(json)).toList();;
      } else {
        throw Exception('Failed to load chat previews ${response.body}');
      }
    } catch (e) {
      print('Error getting chat previews: $e');
      throw Exception('Failed to load chat previews: $e');
    }
  }





  void dispose() {
    print('Disposing ChatProvider');
    socket.disconnect();
    super.dispose();
  }


  Future<void> markMessagesAsRead(String chatId, String userId) async {
    try {
      final response = await http.post(
        Uri.parse('http://your-backend-url/markMessagesAsRead'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'chatId': chatId, 'userId': userId}),
      );

      if (response.statusCode == 200) {
        notifyListeners();
      } else {
        throw Exception('Failed to mark messages as read');
      }
    } catch (error) {
      throw error;
    }
  }



}