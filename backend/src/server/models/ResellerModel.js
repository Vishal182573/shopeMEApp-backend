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

const resellerSchema = new Schema({
  ownerName: {
    required: true,
    type: String,
  },
  businessName: {
    type: String,
    required: true,
    unique: true,
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
  address: {
    type: String,
    required: true,
  },
  contact: {
    type: String,
    required: true,
  },
  city: {
    type: String,
  },
  type: {
    type: String,
  },
  image: {
    type: String,
  },
  bgImage: {
    type: String,
  },
  aboutUs: {
    type: String,
  },
  catalogueCount: {
    type: Number,
  },
  connections: [userConnectionSchema]
}, { timestamps: true });

export default model('Reseller', resellerSchema);
