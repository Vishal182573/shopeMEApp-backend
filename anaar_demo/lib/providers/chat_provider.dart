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
