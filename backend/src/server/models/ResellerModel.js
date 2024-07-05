import { Schema,model } from "mongoose";

const resellerSchema = new Schema({
    ownerName:{
        required:true,
        type:String,
    },
    businessName:{
        type:String,
        required:true,
        unique:true,
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
    address:{
        type:String,
        required:true,
    },
    contact:{
        type:String,
        required:true,
    },
    city:{
        type:String,
    },
    type:{
        type:String,
    },
    image:{
        type:String,
    },
    connections:{
        type:[String] // it contains ids of consumers
    }
},{timestamps:true});

export default model('Reseller',resellerSchema);