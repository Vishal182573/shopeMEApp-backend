import express, { json } from "express";
import cors from "cors";
import dbconnect from "./config/dbConnect.js";
import userRoutes from "./routes/userRoutes.js";
import imageUploader from "./routes/uploadimageRoute.js";
import requirementRoutes from "./routes/requirementRoutes.js";
import postRoutes from "./routes/postRoutes.js";
import ChatRoutes from "./routes/chatRoutes.js";
import CatalogRoutes from "./routes/catalogRoutes.js";
import { Server } from "socket.io";

import http from 'http';
import Chat from './models/ChatModel.js';

const app = express();
const port = process.env.PORT || 3000;
dbconnect();

const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: "*", // Adjust this according to your client's URL
    methods: ["GET", "POST", "PUT", "DELETE"],
    allowedHeaders: ["Content-Type", "Authorization"],
    credentials: true
  }
});

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

io.on('connection', (socket) => {
  console.log('A user connected');

  socket.on('join chat', (chatId) => {
    console.log(`User joined chat: ${chatId}`);
    socket.join(chatId);
  });

  socket.on('send message', async ({ chatId, userId, message }) => {
    console.log(`Received message in chat ${chatId} from user ${userId}: ${message}`);
    try {
      const chat = await Chat.findById(chatId);
      if (!chat) {
        console.error('Chat not found');
        return;
      }

      chat.messages.push({
        userId: userId,
        message: message,
      });
      // const updatedPreview = {
      //   chatId: chatId,
      //   otherUserId: otherUserId,
      //   lastMessage: message.content,
      //   timestamp: message.timestamp,
      //   image: message.senderImage, // or receiver's image
      //   unreadCount: 1, // or calculate based on the unread messages
      // };
  

      await chat.save();
      console.log('Message saved to database');
    //  io.to(otherUserId).emit('chat-preview-updated', updatedPreview);




      io.to(chatId).emit('new message', { userId, message });
      console.log('Message broadcasted to chat room');


      const otherUserId = chat.userId1 === userId ? chat.userId2 : chat.userId1;

     

    } catch (error) {
      console.error('Error sending message:', error);
    }
  });

  socket.on('disconnect', () => {
    console.log('User disconnected');
  });
});

app.get('/', (req, res) => {
  res.json({ message: "Server is running" });
});

app.use("/api/user", userRoutes);
app.use("/api/requirement", requirementRoutes);
app.use("/api/image", imageUploader);
app.use("/api/post", postRoutes);
app.use("/api/chat", ChatRoutes);
app.use("/api/catalog", CatalogRoutes);

server.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
