// import Chat from "../models/ChatModel.js";
// import asyncHandler from "express-async-handler";

// const addChat = asyncHandler(async (req, res) => {
//   try {
//     const { userId1, userId2 } = req.body;
//     if (!userId1 || !userId2) {
//       return res.status(400).json({ message: "Bad request" });
//     }

//     const chat = await Chat.findOne({
//       $or: [
//         { userId1: userId1, userId2: userId2 },
//         { userId1: userId2, userId2: userId1 },
//       ],
//     });

//     if (chat) {
//       return res.status(200).json(chat); 
//     } else {
//       const newChat = new Chat({
//         userId1: userId1,
//         userId2: userId2,
//         messages: [],
//       });

//       const createdChat = await newChat.save();

//       if(createdChat){
//         return res.status(200).json(createdChat);
//       }
//     }
//   } catch (err) {
//     console.error("Error:", err);
//     return res.status(500).json({ message: "Internal Server Error" });
//   }
// });



// const updateChat = asyncHandler(async (req, res) => {
//   try {
//     const { userId1, userId2, message } = req.body;
    
//     if (!userId1 || !userId2 || !message || message === "") {
//       return res.status(400).json({ message: "Bad request" });
//     }

//     // Find the chat document
//     const chat = await Chat.findOne({
//       $or: [
//         { userId1: userId1, userId2: userId2 },
//         { userId1: userId2, userId2: userId1 },
//       ],
//     });

//     if (!chat) {
//       return res.status(404).json({ message: "Chat not found" });
//     }

//     // Push new message to the messages array
//     chat.messages.push({
//       userId: userId1,
//       userId2:userId2,
//       message: message,
//     });

//     // Save the updated chat document
//     const updatedChat = await chat.save();
//     if(updatedChat){
//         return res.status(200).json(chat);
//     }
//   } catch (err) {
//     console.error("Error updating chat:", err);
//     return res.status(500).json({ message: "Internal server error" });
//   }
// });


// export { addChat,updateChat };
import express from 'express';

//import { Server } from 'socket.io';
import  cors from 'cors';
import Chat  from '../models/ChatModel.js';
import Reseller from "../models/ResellerModel.js";
import Consumer from "../models/ConsumerModel.js"
//import User from './models/UserModel.js';
import asyncHandler from "express-async-handler";
import mongoose from 'mongoose';
const app = express();

app.use(cors());
app.use(express.json());

// mongoose.connect('mongodb+srv://chandvipin68:9891277336@cluster0.fkv1agx.mongodb.net/',
//    { useNewUrlParser: true, useUnifiedTopology: true })
//   .then(() => console.log('Connected to MongoDB'))
//   .catch(err => console.error('Could not connect to MongoDB:', err));

// io.on('connection', (socket) => {
//   console.log('A user connected with socket ID:', socket.id);

//   socket.on('join chat', (chatId) => {
//     console.log(`User ${socket.id} joined chat: ${chatId}`);
//     socket.join(chatId);
//   });

//   socket.on('send message', async ({ chatId, userId, message }) => {
//     console.log(`Received message in chat ${chatId} from user ${userId}: ${message}`);
//     try {
//       const chat = await Chat.findById(chatId);
//       if (!chat) {
//         console.error('Chat not found');
//         return;
//       }

//       chat.messages.push({ userId, message });
//       await chat.save();

//       io.to(chatId).emit('new message', { userId, message });
//       console.log(`Broadcasted message to chat room ${chatId}`);
//     } catch (error) {
//       console.error('Error sending message:', error);
//     }
//   });

//   socket.on('disconnect', () => {
//     console.log('User disconnected:', socket.id);
//   });
// });

const addChat= asyncHandler( async (req, res) => {
  try {
    const { userId1, userId2 } = req.body;
    console.log(`Adding chat for users ${userId1} and ${userId2}`);

    let chat = await Chat.findOne({
      $or: [
        { userId1: userId1, userId2: userId2 },
        { userId1: userId2, userId2: userId1 },
      ],
    });

    if (chat) {
      console.log('Existing chat found:', chat);
      return res.status(200).json(chat);
    } else {
      const newChat = new Chat({
        userId1: userId1,
        userId2: userId2,
        messages: [],
      });

      chat = await newChat.save();
      console.log('New chat created:', chat);
      return res.status(201).json(chat);
    }
  } catch (err) {
    console.error("Error in addChat:", err);
    return res.status(500).json({ message: "Internal Server Error", error: err.message });
  }
});
const isValidObjectId = (id) => {
  return mongoose.Types.ObjectId.isValid(id);
};

// const chatPreviews = asyncHandler(async (req, res) => {
//   try {
//     const { id } = req.query;

//     if (!id) {
//       return res.status(400).json({ message: "Bad request: ID is necessary" });
//     }


//     const chats = await Chat.find({
//       $or: [{ userId1: id }, { userId2: id }]
//     }).sort({ updatedAt: -1 });

//     const chatPreviews = await Promise.all(chats.map(async (chat) => {
//       console.log('Processing chat:', chat);  // Added for debugging
//       const otherUserId = chat.userId1 === id ? chat.userId2 : chat.userId1;

//       if (!isValidObjectId(otherUserId)) {
//         console.error('Invalid otherUserId:', otherUserId);  // Added for debugging
//         return null;
//       }

//       const otherUser = await Reseller.findById(otherUserId)??;
//       const lastMessage = chat.messages[chat.messages.length - 1];
//       const unreadCount = chat.messages.filter(m => m.userId !== id && !m.read).length;

//       return {
//         chatId: chat._id,
//         otherUserId: otherUserId,
//         otherUserName: otherUser ? otherUser.businessName : 'Unknown User',
//         lastMessage: lastMessage ? lastMessage.message : '',
//         timestamp: lastMessage ? lastMessage.timestamp : chat.updatedAt,
//         image: otherUser ? otherUser.image : '',
//         unreadCount: unreadCount 
//       };
//     }));

//     // Filter out any null values from invalid user IDs
//     const filteredChatPreviews = chatPreviews.filter(preview => preview !== null);

//     res.json(filteredChatPreviews);
//   } catch (err) {
//     console.error("Error in getChatPreviews:", err);
//     res.status(500).json({ message: "Internal Server Error", error: err.message });
//   }
// });
// const PORT = process.env.PORT || 3000;
// server.listen(PORT, () => {
//   console.log(`Server is running on port ${PORT}`);
// });


const chatPreviews = asyncHandler(async (req, res) => {
  try {
    const { id } = req.query;

    if (!id) {
      return res.status(400).json({ message: "Bad request: ID is necessary" });
    }

    if (!isValidObjectId(id)) {
      return res.status(400).json({ message: "Bad request: Invalid ID format" });
    }

    const chats = await Chat.find({
      $or: [{ userId1: id }, { userId2: id }]
    }).sort({ updatedAt: -1 });

    const chatPreviews = await Promise.all(chats.map(async (chat) => {
      console.log('Processing chat:', chat);  // Added for debugging
      const otherUserId = chat.userId1 === id ? chat.userId2 : chat.userId1;

      if (!isValidObjectId(otherUserId)) {
        console.error('Invalid otherUserId:', otherUserId);  // Added for debugging
        return null;
      }

      // Try to find the other user as a Reseller
      let otherUser = await Reseller.findById(otherUserId);
      let userType = 'Reseller';

      // If not found, try to find the other user as a Consumer
      if (!otherUser) {
        otherUser = await Consumer.findById(otherUserId);
        userType = 'Consumer';
      }

      // If still not found, log an error and skip this chat preview
      if (!otherUser) {
        console.error(`User not found for otherUserId: ${otherUserId}`);
        return null;
      }

      const lastMessage = chat.messages[chat.messages.length - 1];
      const unreadCount = chat.messages.filter(m => m.userId !== id && !m.read).length;

      return {
        chatId: chat._id,
        otherUserId: otherUserId,
        otherUserName: userType === 'Reseller' ? otherUser.businessName : otherUser.name, // Adjust field based on user type
        lastMessage: lastMessage ? lastMessage.message : '',
        timestamp: lastMessage ? lastMessage.timestamp : chat.updatedAt,
        image: otherUser.image || '',
        unreadCount: unreadCount 
      };
    }));

    res.status(200).json(chatPreviews.filter(preview => preview !== null));
  } catch (error) {
    console.error('Error in chatPreviews:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});




const markMessagesAsRead = asyncHandler(async (req, res) => {
  try {
    const { chatId, userId } = req.body;

    if (!chatId || !userId) {
      return res.status(400).json({ message: "Bad request: chatId and userId are required" });
    }

    const chat = await Chat.findById(chatId);

    if (!chat) {
      return res.status(404).json({ message: "Chat not found" });
    }

    chat.messages.forEach(message => {
      if (message.userId !== userId) {
        message.read = true;
      }
    });

    await chat.save();

    res.status(200).json({ message: "Messages marked as read" });
  } catch (err) {
    console.error("Error in markMessagesAsRead:", err);
    res.status(500).json({ message: "Internal Server Error", error: err.message });
  }
});


export { addChat,chatPreviews,markMessagesAsRead};