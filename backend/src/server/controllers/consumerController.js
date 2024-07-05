import Consumer from "../models/ConsumerModel.js";
import asyncHandler from "express-async-handler";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

const consumerRegistration = asyncHandler(async (req, res) => {
  try {
    const {  name, email, password, contact,city, image, connections } = req.body;
    if (!name ||!businessname || !email || !password || !contact || !city) {
      return res.status(400).json({ message: "Bad request: Missing required fields" });
    }

    const existingConsumer = await Consumer.findOne({ email });
    if (existingConsumer) {
      return res.status(401).json({ message: "Consumer already exists" });
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    const newConsumer = new Consumer({
      name,
      email,
      password: hashedPassword,
      contact,
      city,
      type:"consumer",
      image:image || "",
      connections : connections || [""],
    });

    const savedConsumer = await newConsumer.save();
    const payload = {
      consumer: {
        id: savedConsumer._id,
      },
      "type":"Consumer"
    };

    jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '1h' }, (err, token) => {
      if (err) {
        return res.status(500).json({ message: "Token generation failed" });
      }
      res.status(200).json({ token, message: "Registration successful" });
    });

  } catch (err) {
    return res.status(500).json({ message: "Internal server error" });
  }
});

const consumerLogin = asyncHandler(async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({ message: "Bad request: Missing required fields" });
    }

    const consumer = await Consumer.findOne({ email });
    if (!consumer) {
      return res.status(404).json({ message: "Consumer not found" });
    }

    const isMatch = await bcrypt.compare(password, consumer.password);
    if (isMatch) {
      const payload = {
        consumer: {
          id: consumer._id,

        },
        "type":"consumer"

      };

      jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: "1h" }, (err, token) => {
        if (err) {
          return res.status(500).json({ message: "Token generation failed" });
        }
        return res.status(200).json({ token, message: "Login successful" });
      });
    } else {
      return res.status(401).json({ message: "Incorrect password" });
    }
  } catch (err) {
    return res.status(500).json({ message: "Internal server error" });
  }
});

const getConsumer = asyncHandler(async (req, res) => {
  try {
    const { id } = req.query;
    if (!id) return res.status(400).json({ message: "Bad request: ID is necessary" });

    const consumer = await Consumer.findById(id);
    if (!consumer) {
      return res.status(404).json({ message: "Consumer not found" });
    }
    return res.status(200).json(consumer);
  } catch (err) {
    return res.status(500).json({ message: "Internal server error" });
  }
});

export { consumerRegistration, consumerLogin, getConsumer };
