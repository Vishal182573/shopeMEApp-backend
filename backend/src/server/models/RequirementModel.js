import { Schema,model } from "mongoose";

const requirementSchema = new Schema({
    userId:{
        type:String,
        required:true,
    },
    productName:{
        type:String,
        required:true,
    },
    category:{
        type:String,
        required:true,
    },
    quantity:{
        type:Number,
        required:true,
    },
    totalPrice:{
        type:Number,
        required:true,
    },
    details:String,
    images:{
        type:[String],
    }
},{timestamps:true});

export default model('Requirement',requirementSchema);