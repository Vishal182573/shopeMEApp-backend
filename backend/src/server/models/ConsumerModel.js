import { Schema, model } from "mongoose";

const userConnectionSchema = new Schema({
  userId: {
    type: Schema.Types.ObjectId,
    required: true
  },
  Type: {
    type: String,
    required: true
  }
}, { _id: false });

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
  connections: [userConnectionSchema]
}, { timestamps: true });

export default model('Consumer', consumerSchema);