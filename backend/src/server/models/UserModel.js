import { Schema, model } from "mongoose";

// Define the User schema
const userSchema = new Schema({
  userId:{
    type:String,
  },
  Type: {
    type: String,
  }
}, { timestamps: true });

export const User = model('User', userSchema);
