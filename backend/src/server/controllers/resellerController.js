import Reseller from "../models/ResellerModel.js";
import asyncHandler from "express-async-handler";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

const resellerRegistration = asyncHandler(async (req, res) => {
  try {
    const { ownerName, businessName, email, password, address, contact, city, image, connections } = req.body;
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
      connections: connections || [""],
    });

    const savedReseller = await newReseller.save();
    const payload = {
      reseller: {
        id: savedReseller._id,
      },
      type:"reseller"
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
        type:"reseller"
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

export { resellerRegistration, resellerLogin, getReseller };
