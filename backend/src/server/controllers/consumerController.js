import Consumer from "../models/ConsumerModel.js";
import Reseller from "../models/ResellerModel.js"
import asyncHandler from "express-async-handler";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

const consumerRegistration = asyncHandler(async (req, res) => {
  try {
    const { name, email, password, contact,city, image, bio } = req.body;
    if (!name || !email || !password || !contact || !city) {
      return res.status(400).json({ message: "Bad request: Missing required fields" });
    }
    const existingConsumer = await Consumer.findOne({ email });
    if (existingConsumer) {
      return res.status(400).json({ message: "Consumer already exists" });
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
      bio: bio || "",
      connections : []
    });
    const savedConsumer = await newConsumer.save();
    const payload = {
      consumer: {
        id: savedConsumer._id,
      },
    };

    jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '1h' }, (err, token) => {
      if (err) {
        return res.status(500).json({ message: "Token generation failed" });
      }
      res.status(200).json({ token, message: "Registration successful",session:{id: savedConsumer._id,type:"consumer"}});
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
      };

      jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: "1h" }, (err, token) => {
        if (err) {
          return res.status(500).json({ message: "Token generation failed" });
        }
        return res.status(200).json({ token, message: "Login successful",session:{id: consumer._id,type:"consumer"}});
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

const getConsumers = asyncHandler(async (req, res) => {
  try {
    const reseller = await Consumer.find({});
    return res.status(200).json(reseller);
  } catch (err) {
    return res.status(500).json({ message: "Internal server error" });
  }
});

const updateConsumer = asyncHandler(async (req, res) => {
  try {
    const { name, email, password, contact, city, image,bio,connections } = req.body;
    
    if (!email) {
      return res.status(400).json({ message: "Bad request: Missing required email" });
    }

    const consumer = await Consumer.findOne({ email });
    if (!consumer) {
      return res.status(404).json({ message: "Consumer not found" });
    }

    // Only update the fields that are provided in the request body
    if (name) consumer.name = name;
    if (password) consumer.password = password;
    if (contact) consumer.contact = contact;
    if (city) consumer.city = city;
    if (image) consumer.image = image;
    if (bio) consumer.bio = bio;
    if (connections) consumer.connections = connections;

    const updatedConsumer = await consumer.save();

    return res.status(200).json(updatedConsumer);

  } catch (err) {
    return res.status(500).json({ message: "Internal server error" });
  }
});

const resellerToConsumer = asyncHandler(async (req, res) => {
  try {
    const { resellerId, consumerId } = req.body;
    if (!resellerId || !consumerId) return res.status(400).json({ message: "Bad request" });

    const reseller = await Reseller.findById(resellerId);
    const consumer = await Consumer.findById(consumerId);
    
    if (!reseller || !consumer) {
      return res.status(404).json({ message: "User not found" });
    }

    // Check if connection already exists
    const existingResellerConnection = reseller.connections.find(
      conn => conn.userId.toString() === consumerId && conn.Type === "consumer"
    );
    const existingConsumerConnection = consumer.connections.find(
      conn => conn.userId.toString() === resellerId && conn.Type === "reseller"
    );

    if (existingResellerConnection || existingConsumerConnection) {
      return res.status(400).json({ message: "Users are already connected" });
    }

    reseller.connections.push({ userId: consumerId, Type: 'consumer' });
    consumer.connections.push({ userId: resellerId, Type: 'reseller' });
    
    await reseller.save();
    await consumer.save();
    
    return res.status(200).json({ message: "Users connected successfully" });
  } catch (err) {
    return res.status(500).json({ message: "Internal Server Error" });
  }
});

const consumerToConsumer = asyncHandler(async (req, res) => {
  try {
    const { consumerId1, consumerId2 } = req.body;
    if (!consumerId1 || !consumerId2) return res.status(400).json({ message: "Bad request" });

    const consumer1 = await Consumer.findById(consumerId1);
    const consumer2 = await Consumer.findById(consumerId2);
    
    if (!consumer1 || !consumer2) {
      return res.status(404).json({ message: "User not found" });
    }

    // Check if connection already exists
    const existingConnection1 = consumer1.connections.find(
      conn => conn.userId.toString() === consumerId2 && conn.Type === "consumer"
    );
    const existingConnection2 = consumer2.connections.find(
      conn => conn.userId.toString() === consumerId1 && conn.Type === "consumer"
    );

    if (existingConnection1 || existingConnection2) {
      return res.status(400).json({ message: "Users are already connected" });
    }

    consumer1.connections.push({ userId: consumerId2, Type: 'consumer' });
    consumer2.connections.push({ userId: consumerId1, Type: 'consumer' });
    
    await consumer1.save();
    await consumer2.save();
    
    return res.status(200).json({ message: "Users connected successfully" });
  } catch (err) {
    return res.status(500).json({ message: "Internal Server Error" });
  }
});

export { consumerRegistration, consumerLogin, getConsumer,updateConsumer,consumerToConsumer,resellerToConsumer,getConsumers };
