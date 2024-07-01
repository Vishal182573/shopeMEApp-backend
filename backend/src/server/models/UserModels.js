import { Schema,model } from "mongoose";

const userSchema = new Schema({
    name:{
        required:true,
        type:String,
    },
    email:{
        required:true,
        type:String,
        unique:true,
    },
    password:{
        required:true,
        type:String,
    },
},{timestamps:true});

export default model('User',userSchema);