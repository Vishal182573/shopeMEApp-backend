import { Schema,model } from "mongoose";

const consumerSchema = new Schema({
    ownername:{
        required:true,
        type:String,
    },
    businessname:{
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
    contact:{
        type:String,
        required:true,
    },
    city:{
        required:true,
        type:String,
    },
    image:{
        type:String,
    },
    connections:{
        type:[String], // it have id of resellers
    }
},{timestamps:true});

export default model('Consumer',consumerSchema);