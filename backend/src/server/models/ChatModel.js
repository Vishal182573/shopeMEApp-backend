import { model,Schema } from "mongoose";
import mongoose from 'mongoose';
// // Define the message schema
// const messageSchema = new Schema({
//   userId: {
//     type: String,
//     required: true
//   },
//   userId2:{
//     type:String,
//     required:true,
//   },
//   message: {
//     type: String,
//     required: true
//   }
// });

// // Define the main schema
// const chatSchema = new Schema({
//   userId1: {
//     type: String,
//     required: true,
//   },
//   userId2: {
//     type: String,
//     required: true,
//   },
//   messages: [messageSchema]
// });


const ChatSchema = new Schema({
  userId1: String,
  userId2: String,
  messages: [{
    userId: String,
    message: String,
    unread:Boolean,
    timestamp: { type: Date, default: Date.now }
  }]
}, { timestamps: true });



// Create the model
export default model('Chat', ChatSchema);

