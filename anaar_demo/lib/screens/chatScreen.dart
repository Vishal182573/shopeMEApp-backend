// import 'package:anaar_demo/providers/chat_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:anaar_demo/model/userModel.dart';


// class ChatScreen extends StatefulWidget {
//   final String loggedInUserId;
//   final String postOwnerId;

//   ChatScreen({required this.loggedInUserId, required this.postOwnerId});

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Initialize chat or fetch existing chat
//     Provider.of<ChatProvider>(context, listen: false).initializeChat(
//       widget.loggedInUserId,
//       widget.postOwnerId,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Chat')),
//       body: Column(
//         children: [
//           Expanded(
//             child: Consumer<ChatProvider>(
//               builder: (context, chatProvider, child) {
//                 return ListView.builder(
//                   itemCount: chatProvider.messages.length,
//                   itemBuilder: (context, index) {
//                     final message = chatProvider.messages[index];
//                     return ListTile(
//                       title: Text(message.message),
//                       subtitle: Text(message.userId == widget.loggedInUserId ? 'You' : 'Other'),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(hintText: 'Type a message'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     if (_messageController.text.isNotEmpty) {
//                       Provider.of<ChatProvider>(context, listen: false).sendMessage(
//                         widget.loggedInUserId,
//                         widget.postOwnerId,
//                         _messageController.text,
//                       );
//                       _messageController.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:anaar_demo/model/reseller_model.dart';
import 'package:anaar_demo/model/userModel.dart';
import 'package:anaar_demo/providers/chat_provider.dart';
import 'package:anaar_demo/screens/TrendingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';


// class ChatScreen extends StatefulWidget {
//   final String? loggedInUserId;
//   final String postOwnerId;
//   Reseller? reseller;
//   Usermodel? user;

//   ChatScreen({required this.loggedInUserId, required this.postOwnerId, this.user,this.reseller});

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     print('ChatScreen initialized');
//     final chatProvider = Provider.of<ChatProvider>(context, listen: false);
//     chatProvider.initSocket();
//     chatProvider.initializeChat(widget.loggedInUserId, widget.postOwnerId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
    
//     Scaffold(
//       backgroundColor: Color.fromARGB(255, 233, 233, 233),
//       appBar: AppBar(title: Text(widget.user?.businessName??widget.reseller?.businessName??'',
      
//       style: TextStyle(
//         color: Colors.black),
//         ),
//       automaticallyImplyLeading: false,
//       leading: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: CircleAvatar(backgroundImage: NetworkImage(widget.user?.image??
//         widget.reseller?.image??'',),maxRadius: 10,),
//       ),
      
     
//       backgroundColor: Colors.red,
//       leadingWidth: 50,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//   child: Consumer<ChatProvider>(
//     builder: (context, chatProvider, child) {
//       return ListView.builder(
//         itemCount: chatProvider.messages.length,
//         itemBuilder: (context, index) {
//           final message = chatProvider.messages[index];
//           return message.userId == widget.loggedInUserId
//               ? Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 10),
//                     child: SenderMessagecard(message: message.message),
//                   ),
//                 )
//               : Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ReceiverMessagecard(message: message.message),
//                   ),
//                 );
//         },
//       );
//     },
//   ),
// ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
                      
//                       hintText: 'Type a message',border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide(color: Colors.red))),),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red),
//                   child: Center(
//                     child: IconButton(
//                       icon: Icon(Icons.send,color: Colors.white,),
//                       onPressed: () {
//                         if (_messageController.text.isNotEmpty) {
//                           print('Sending message: ${_messageController.text}');
//                           Provider.of<ChatProvider>(context, listen: false).sendMessage(
//                             widget.loggedInUserId,
//                             _messageController.text,
//                           );
//                           _messageController.clear();
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );





//   }

// // Widget  _buildMessageList(){
// //        return StreamBuilder(stream: stream, 
// //        builder: builder)
 

// // }
  
//   @override
//   void dispose() {
//     print('Disposing ChatScreen');
//     Provider.of<ChatProvider>(context, listen: false).dispose();
//     super.dispose();
//   }
// }

// class SenderMessagecard extends StatelessWidget{
//   String message;
//   SenderMessagecard({required this.message});
// @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Container(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(message,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
//           ),
//           decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),
//           bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)
          
//           ),
//           color: Colors.red.withOpacity(0.5),
//            border: Border.all(color: Colors.red,style: BorderStyle.solid,width: 1.2)          
//           ),
      
      
//       ),
//     );
//   }


// }



// class ReceiverMessagecard extends StatelessWidget{
//   String message;
// ReceiverMessagecard({required this.message});
// @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Container(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(message,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
//           ),
//           decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(15),
//           bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)
          
//           ),
//           color: Colors.blue.withOpacity(0.5),
//            border: Border.all(color: Colors.blue,style: BorderStyle.solid,width: 1.2)
//           ),
      
      
//       ),
//     );
//   }


// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatScreen extends StatefulWidget {
  final String? loggedInUserId;
  final String postOwnerId;
  Reseller? reseller;
  Usermodel? user;

  ChatScreen({
    required this.loggedInUserId,
    required this.postOwnerId,
    this.user,
    this.reseller,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    chatProvider.initSocket();
    chatProvider.initializeChat(widget.loggedInUserId, widget.postOwnerId);
// chatProvider.initialize();


    // Scroll to bottom when keyboard is focused
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollToBottom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 233, 233),
      appBar: AppBar(
        title: Text(
          widget.user?.businessName ?? widget.reseller?.businessName ?? '',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(widget.user?.image ?? widget.reseller?.image ?? ''),
            maxRadius: 10,
          ),
        ),
        backgroundColor: Colors.red,
        leadingWidth: 50,
      ),
      body: Container(
     decoration: BoxDecoration(image: DecorationImage(
      fit: BoxFit.cover,
      image:AssetImage('assets/images/chatBg.png'))),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<ChatMessage>>(
                stream: chatProvider.messageStream, // The message stream
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
        
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No messages yet."));
                  }
        
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom();
                  });
        
                  final messages = snapshot.data!;
                  return ListView.builder(
                    controller: _scrollController,
                    
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return message.userId == widget.loggedInUserId
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SenderMessageCard(message: message.message),
                              ),
                            )
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ReceiverMessageCard(message: message.message),
                              ),
                            );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                   //   scrollController: _scrollController,
                    // maxLines: 44,
                      keyboardType: TextInputType.multiline,
                     // expands: true,
                      focusNode: _focusNode,
                      controller: _messageController,
                      
                      decoration: InputDecoration(
                        
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (_messageController.text.isNotEmpty) {
                            chatProvider.sendMessage(
                              widget.loggedInUserId,
                              _messageController.text,
                            );
                            _messageController.clear();
                            _scrollToBottom();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    _focusNode.dispose();
    Provider.of<ChatProvider>(context, listen: false).dispose();
    super.dispose();
  }
}

class SenderMessageCard extends StatelessWidget {
  final String message;
  SenderMessageCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          color: Colors.red.withOpacity(0.5),
          border: Border.all(color: Colors.red, style: BorderStyle.solid, width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}

class ReceiverMessageCard extends StatelessWidget {
  final String message;
  ReceiverMessageCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          color: Colors.blue.withOpacity(0.5),
          border: Border.all(color: Colors.blue, style: BorderStyle.solid, width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}