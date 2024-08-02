import { Schema, model } from "mongoose";
import { User } from "./UserModel.js"; // Adjust the path as necessary

const consumerSchema = new Schema({
  name: {
    required: true,
    type: String,
  },
  email: {
    required: true,
    type: String,
    unique: true,
  },
  password: {
    required: true,
    type: String,
  },
  contact: {
    type: String,
    required: true,
  },
  city: {
    required: true,
    type: String,
  },
  type: {
    type: String,
  },
  image: {
    type: String,
  },
  bio: {
    type: String,
  },
  connections: [{
    type: Schema.Types.ObjectId,
    ref: 'User'
  }]
}, { timestamps: true });

export default model('Consumer', consumerSchema);
