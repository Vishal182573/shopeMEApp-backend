// import 'package:anaar_demo/helperfunction/helperfunction.dart';
// import 'package:anaar_demo/model/chat_message_model.dart';
// import 'package:anaar_demo/model/userModel.dart';
// import 'package:anaar_demo/providers/chat_provider.dart';
// import 'package:anaar_demo/screens/chatScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class MessageListScreen extends StatefulWidget {
//   @override
//   State<MessageListScreen> createState() => _MessageListScreenState();
// }

// class _MessageListScreenState extends State<MessageListScreen> {
//   String? loggedInUserId;

//   @override
//   void initState() {
//     super.initState();
//     _loaduserid();
//   }

//   void _loaduserid() async {
//     loggedInUserId = await Helperfunction.getUserId();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Messages'),
//         backgroundColor: Colors.red,
//       ),
//       body: FutureBuilder<List<ChatPreview>>(
//         future: Provider.of<ChatProvider>(context, listen: false).getChatPreviews(loggedInUserId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             // Sort chats so that those with unread messages are at the top
//             snapshot.data!.sort((a, b) {
//               if (a.unreadCount > 0 && b.unreadCount == 0) {
//                 return -1;
//               } else if (a.unreadCount == 0 && b.unreadCount > 0) {
//                 return 1;
//               } else {
//                 return 0;
//               }
//             });

//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final chatPreview = snapshot.data![index];

//                 return ListTile(
//                   dense: true,
//                   leading: CircleAvatar(
//                     backgroundImage: chatPreview.image.isNotEmpty
//                         ? NetworkImage(chatPreview.image)
//                         : NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsyA44JdhHChP6kGqx36BolQq4Hn7z2yGekw&s"),
//                   ),
//                   title: Text(chatPreview.otherUserName),
//                   subtitle: Text(chatPreview.lastMessage),
//                   trailing: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         chatPreview.timestamp.isEmpty ? "time" : '${DateTime.parse(chatPreview.timestamp).hour}:${DateTime.parse(chatPreview.timestamp).minute}',
//                         style: TextStyle(color: const Color.fromARGB(255, 3, 2, 2)),
//                       ),
//                       if (chatPreview.unreadCount > 0)
//                         Container(
//                           padding: EdgeInsets.all(6.0),
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           child: Text(
//                             '${chatPreview.unreadCount}',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                     ],
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ChatScreen(
//                           loggedInUserId: loggedInUserId,
//                           postOwnerId: chatPreview.otherUserId,
//                           user: Usermodel(
//                             id: chatPreview.otherUserId,
//                             businessName: chatPreview.otherUserName,
//                             connections: [],
//                             image: chatPreview.image
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }


import 'package:anaar_demo/helperfunction/helperfunction.dart';
import 'package:anaar_demo/model/chat_message_model.dart';
import 'package:anaar_demo/model/userModel.dart';
import 'package:anaar_demo/providers/chat_provider.dart';
import 'package:anaar_demo/screens/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class MessageListScreen extends StatefulWidget {
//   @override
//   State<MessageListScreen> createState() => _MessageListScreenState();
// }

// class _MessageListScreenState extends State<MessageListScreen> {
//   String? loggedInUserId;
//   String? userType;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserId();
//   }

//   void _loadUserId() async {
//     loggedInUserId = await Helperfunction.getUserId();
//     setState(() {});
//   }

//   void _markMessagesAsRead(String chatId) {
//     Provider.of<ChatProvider>(context, listen: false).markMessagesAsRead(chatId, loggedInUserId!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(automaticallyImplyLeading: false,
//         title: Text('Messages',style: TextStyle(color: Colors.white),),
//         backgroundColor: Colors.red,
//       ),
//       body: FutureBuilder<List<ChatPreview>>(
//         future: Provider.of<ChatProvider>(context, listen: false).getChatPreviews(loggedInUserId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final chatPreview = snapshot.data![index];

//                 return ListTile(
//                   dense: true,
//                   leading: CircleAvatar(
//                     backgroundImage: chatPreview.image != null
//                         ? NetworkImage(chatPreview.image)
//                         : NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsyA44JdhHChP6kGqx36BolQq4Hn7z2yGekw&s"),
//                   ),
//                   title: Text(chatPreview.otherUserName),
//                   subtitle: Text(chatPreview.lastMessage),
//                   trailing: chatPreview.unreadCount > 0
//                       ? Badge(
//                           label: Text(
//                             chatPreview.unreadCount.toString(),
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           child: Text(
//                             chatPreview.timestamp == ''
//                                 ? "time"
//                                 : '${DateTime.parse(chatPreview.timestamp).hour}:${DateTime.parse(chatPreview.timestamp).minute}',
//                             style: TextStyle(color: const Color.fromARGB(255, 3, 2, 2)),
//                           ),
//                         )
//                       : Text(
//                           chatPreview.timestamp == ''
//                               ? "time"
//                               : '${DateTime.parse(chatPreview.timestamp).hour}:${DateTime.parse(chatPreview.timestamp).minute}',
//                           style: TextStyle(color: const Color.fromARGB(255, 3, 2, 2)),
//                         ),
//                   onTap: () {
//                     _markMessagesAsRead(chatPreview.chatId);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ChatScreen(
//                           loggedInUserId: loggedInUserId,
//                           postOwnerId: chatPreview.otherUserId,
//                           user: Usermodel(
//                             id: chatPreview.otherUserId,
//                             businessName: chatPreview.otherUserName,
//                             connections: [],
//                             image: chatPreview.image,
//                           ),
//                         ),
//                       ),
//                     ).then((_) {
//                       setState(() {});
//                     });
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

class MessageListScreen extends StatefulWidget {
  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  String? loggedInUserId;
  Future<List<ChatPreview>>? chatPreviewsFuture;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  void _loadUserId() async {
    loggedInUserId = await Helperfunction.getUserId();
    _loadChatPreviews();
  }

  void _loadChatPreviews() {
    setState(() {
      chatPreviewsFuture = Provider.of<ChatProvider>(context, listen: false).getChatPreviews(loggedInUserId);
    });
  }

  Future<void> _markMessagesAsRead(String chatId) async {
    await Provider.of<ChatProvider>(context, listen: false).markMessagesAsRead(chatId, loggedInUserId!);
    _loadChatPreviews(); // Reload chat previews after marking messages as read
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      //backgroundColor: LinearGradient(colors: colors),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Messages', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<List<ChatPreview>>(
        future: chatPreviewsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No messages'));
          } else {
            return ListView.separated(
              separatorBuilder: (context,builder){
                return Divider();
              },
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final chatPreview = snapshot.data![index];

                return Card(
                  color: Colors.white,
                  elevation: 8,
                  child: ListTile(
                    
                    dense: true,
                    leading: CircleAvatar(
                      backgroundImage: chatPreview.image != ''
                          ? NetworkImage(chatPreview.image)
                          : AssetImage('assets/images/profileavtar.jpg'),
                    ),
                    title: Text(chatPreview.otherUserName),
                    subtitle: Text(chatPreview.lastMessage),
                    trailing: chatPreview.unreadCount > 0
                        ? Badge(
                            label: Text(
                              chatPreview.unreadCount.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            child: Text(
                              chatPreview.timestamp == ''
                                  ? "time"
                                  : '${DateTime.parse(chatPreview.timestamp).hour}:${DateTime.parse(chatPreview.timestamp).minute}',
                              style: TextStyle(color: const Color.fromARGB(255, 3, 2, 2)),
                            ),
                          )
                        : Text(
                            chatPreview.timestamp == ''
                                ? "time"
                                : '${DateTime.parse(chatPreview.timestamp).hour}:${DateTime.parse(chatPreview.timestamp).minute}',
                            style: TextStyle(color: const Color.fromARGB(255, 3, 2, 2)),
                          ),
                    onTap: () async {
                      await _markMessagesAsRead(chatPreview.chatId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            loggedInUserId: loggedInUserId,
                            postOwnerId: chatPreview.otherUserId,
                            user: Usermodel(
                              id: chatPreview.otherUserId,
                              businessName: chatPreview.otherUserName,
                              connections: [],
                              image: chatPreview.image,
                            ),
                          ),
                        ),
                      ).then((_) {
                        _loadChatPreviews(); // Refresh the chat previews after returning from the chat screen
                      });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
