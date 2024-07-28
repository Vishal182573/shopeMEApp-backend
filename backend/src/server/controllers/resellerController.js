import Reseller from "../models/ResellerModel.js";
import Consumer from "../models/ConsumerModel.js"
import asyncHandler from "express-async-handler";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

const resellerRegistration = asyncHandler(async (req, res) => {
  try {
    const { ownerName, businessName, email, password, address, contact, city, image, bgImage,connections } = req.body;
    if (!ownerName || !businessName || !email || !password || !address || !contact) {
      return res.status(400).json({ message: "Bad request: Missing required fields" });
    }

    const existingReseller = await Reseller.findOne({ email });
    if (existingReseller) {
      return res.status(401).json({ message: "Reseller already exists" });
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    const newReseller = new Reseller({
      ownerName,
      businessName,
      email,
      password: hashedPassword,
      address,
      contact,
      city:city || "",
      type:"reseller",
      image:image || "",
      bgImage: bgImage || "",
      connections: connections || [],
    });

    const savedReseller = await newReseller.save();
    const payload = {
      reseller: {
        id: savedReseller._id,
      },
    };

    jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '1h' }, (err, token) => {
      if (err) {
        return res.status(500).json({ message: "Token generation failed" });
      }
      res.status(200).json({ token, message: "Registration successful",session:{id: savedReseller._id,type:"reseller"}});
    });

  } catch (err) {
    return res.status(500).json({ message: "Internal server error" });
  }
});

const resellerLogin = asyncHandler(async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({ message: "Bad request: Missing required fields" });
    }

    const reseller = await Reseller.findOne({ email });
    if (!reseller) {
      return res.status(404).json({ message: "Reseller not found" });
    }
    const isMatch = await bcrypt.compare(password, reseller.password);
    if (isMatch) {
      const payload = {
        reseller: {
          id: reseller._id,
        },
      };

      jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: "1h" }, (err, token) => {
        if (err) {
          return res.status(500).json({ message: "Token generation failed" });
        }
        return res.status(200).json({ token, message: "Login successful",session:{id: reseller._id,type:"reseller"}});
      });
    } else {
      return res.status(401).json({ message: "Incorrect password" });
    }
  } catch (err) {
    return res.status(500).json({ message: "Internal server error" });
  }
});

const getReseller = asyncHandler(async (req, res) => {
  try {
    const { id } = req.query;
    if (!id) return res.status(400).json({ message: "Bad request: ID is necessary" });

    const reseller = await Reseller.findById(id);
    if (!reseller) {
      return res.status(404).json({ message: "Reseller not found" });
    }
    return res.status(200).json(reseller);
  } catch (err) {
    return res.status(500).json({ message: "Internal server error" });
  }
});

const updateReseller = asyncHandler(async (req, res) => {
  try {
    const { ownerName, businessName, email, password, address, contact, city, image, bgImage, connections } = req.body;
    
    if (!email) {
      return res.status(400).json({ message: "Bad request: Missing required email" });
    }

    const reseller = await Reseller.findOne({ email });
    if (!reseller) {
      return res.status(404).json({ message: "Reseller not found" });
    }

    // Only update the fields that are provided in the request body
    if (ownerName) reseller.ownerName = ownerName;
    if (businessName) reseller.businessName = businessName;
    if (password) reseller.password = password;
    if (address) reseller.address = address;
    if (contact) reseller.contact = contact;
    if (city) reseller.city = city;
    if (image) reseller.image = image;
    if (bgImage) reseller.bgImage = bgImage;
    if (connections) reseller.connections = connections;

    const updatedReseller = await reseller.save();

    return res.status(200).json(updatedReseller);

  } catch (err) {
    return res.status(500).json({ message: "Internal server error" });
  }
});

const consumerToReseller = asyncHandler(async (req, res) => {
  try {
    const { consumerId, resellerId } = req.body;
    if (!consumerId || !resellerId) return res.status(400).json({ message: "Bad request" });

    const reseller = await Reseller.findById(resellerId);
    const consumer = await Consumer.findById(consumerId);
    if (!reseller || !consumer) {
      return res.status(404).json({ message: "User not found" });
    } else {
      reseller.connections.push({ id: consumerId, type: 'consumer' });
      consumer.connections.push({ id: resellerId, type: 'reseller' });
      await reseller.save();
      await consumer.save();
      return res.status(200).json({ message: "Users connected successfully" });
    }
  } catch (err) {
    return res.status(500).json({ message: "Internal Server Error" });
  }
});

const resellerToReseller = asyncHandler(async (req, res) => {
  try {
    const { resellerId1, resellerId2 } = req.body;
    if (!resellerId1 || !resellerId2) return res.status(400).json({ message: "Bad request" });

    const reseller1 = await Reseller.findById(resellerId1);
    const reseller2 = await Reseller.findById(resellerId2);
    if (!reseller1 || !reseller2) {
      return res.status(404).json({ message: "User not found" });
    } else {
      reseller1.connections.push({ id: resellerId2, type: 'reseller' });
      reseller2.connections.push({ id: resellerId1, type: 'reseller' });
      await reseller1.save();
      await reseller2.save();
      return res.status(200).json({ message: "Users connected successfully" });
    }
  } catch (err) {
    return res.status(500).json({ message: "Internal Server Error" });
  }
});

export { resellerRegistration, resellerLogin, getReseller, resellerToReseller,consumerToReseller,updateReseller };
