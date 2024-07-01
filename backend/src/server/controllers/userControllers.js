import User from "../models/UserModels.js";
import asyncHanlder from "express-async-handler";

const userRegisteration = asyncHanlder(async (req, res) => {
  try {
    const { name, email, password } = req.body;
    if (!name || !email || !password){
        return res.status(400).json({ message: "Bad request" });
    }
    const user = await User.findOne({email});
    if(user){
        return res.status(401).json({message:"User already exists"});
    }
    const newuser = new User({
        name,
        email,
        password,
    });
    const savedUser = await newuser.save();
    if(savedUser) return res.status(200).json({message:"Registration Succesfull"});
    throw new Error("Something went wrong");
  } catch (err) {
    return res.status(500).json({ message: "Internal server error" });
  }
});

const userLogin = asyncHanlder(async (req, res) => {
    try{
        const {email,password} = req.body;
        if(!email || !password){
            return res.status(400).json({message:"Bad request"});
        }
        const user = await User.findOne({email});
        if(!user){
            return res.status(404).json({message:"User not found"});
        }
        if(user.password === password){
            return res.status(200).json({message:"Login succesfull"})
        }
        return res.status(401).json({message:"Incorrect password"});
    }catch(err){
        return res.status(500).json({message:"Internal server error"});
    }
});

export { userRegisteration, userLogin };
