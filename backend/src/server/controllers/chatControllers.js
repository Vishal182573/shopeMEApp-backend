import Chat from "../models/ChatModel.js";
import asyncHandler from "express-async-handler";

const addChat = asyncHandler(async (req, res) => {
  try {
    const { userId1, userId2 } = req.body;
    if (!userId1 || !userId2) {
      return res.status(400).json({ message: "Bad request" });
    }

    const chat = await Chat.findOne({
      $or: [
        { userId1: userId1, userId2: userId2 },
        { userId1: userId2, userId2: userId1 },
      ],
    });

    if (chat) {
      return res.status(200).json(chat); 
    } else {
      const newChat = new Chat({
        userId1: userId1,
        userId2: userId2,
        messages: [],
      });

      const createdChat = await newChat.save();

      if(createdChat){
        return res.status(200).json(createdChat);
      }
    }
  } catch (err) {
    console.error("Error:", err);
    return res.status(500).json({ message: "Internal Server Error" });
  }
});



const updateChat = asyncHandler(async (req, res) => {
  try {
    const { userId1, userId2, message } = req.body;
    
    if (!userId1 || !userId2 || !message || message === "") {
      return res.status(400).json({ message: "Bad request" });
    }

    // Find the chat document
    const chat = await Chat.findOne({
      $or: [
        { userId1: userId1, userId2: userId2 },
        { userId1: userId2, userId2: userId1 },
      ],
    });

    if (!chat) {
      return res.status(404).json({ message: "Chat not found" });
    }

    // Push new message to the messages array
    chat.messages.push({
      userId: userId1,
      userId2:userId2,
      message: message,
    });

    // Save the updated chat document
    const updatedChat = await chat.save();
    if(updatedChat){
        return res.status(200).json(chat);
    }
  } catch (err) {
    console.error("Error updating chat:", err);
    return res.status(500).json({ message: "Internal server error" });
  }
});


export { addChat,updateChat };