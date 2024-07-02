import User from "../models/UserModels.js";
import asyncHandler from "express-async-handler";
import bcrypt from "bcryptjs"
import jwt from "jsonwebtoken"
import dotenv from "dotenv"

dotenv.config();


const userRegistration = asyncHandler(async (req, res) => {
    try {
      let { name, email, password } = req.body;
      if (!name || !email || !password) {
        return res.status(400).json({ message: "Bad request" });
      }
  
      const user = await User.findOne({ email });
      if (user) {
        return res.status(401).json({ message: "User already exists" });
      }
  
      const salt = await bcrypt.genSalt(10);
      password = await bcrypt.hash(password, salt);
  
      const newUser = new User({
        name,
        email,
        password,
      });
  
      const savedUser = await newUser.save();
      const payload = {
        user: {
          id: savedUser._id,
        },
      };
  
      jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '1h' }, (err, token) => {
        if (err) {
          return res.status(500).json({ message: "Token generation failed" });
        }
        res.status(200).json({ token });
      });
  
    } catch (err) {
      console.error(err);
      return res.status(500).json({ message: "Internal server error" });
    }
  });
  

const userLogin = asyncHandler(async (req, res) => {
    try{
        const {email,password} = req.body;
        if(!email || !password){
            return res.status(400).json({message:"Bad request"});
        }
        const user = await User.findOne({email});
        if(!user){
            return res.status(404).json({message:"User not found"});
        }
        const isMatch = await bcrypt.compare(password,user.password);
        if(isMatch){
            const payload = {
                id:user._id,
            }
            jwt.sign(payload,process.env.JWT_SECRET,{expiresIn:"1h"},(err,token)=>{
                if(err){
                    return res.status(500).json({message:"Token generation failed"});
                }
                return res.status(200).json({token,message:"Login succesfull"})
            })
        }else{
            return res.status(401).json({message:"Incorrect password"});
        }
    }catch(err){
        return res.status(500).json({message:"Internal server error"});
    }
});

const getUser = asyncHandler(async(req,res)=>{
    try{
        const {id} = req.query;
        if(!id) return res.status(400).json({message:"Bad request"});
        const user = await User.findOne({_id:id});
        if(!user){
            return res.status(404).json({message:"User not found"});
        }
        return res.status(200).json(user);
    }catch(err){
        return res.status(500).json({message:"Internal Server Error"});
    }
});

export { userRegistration, 
         userLogin,
         getUser,
};
