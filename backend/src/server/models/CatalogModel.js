import { Schema,model } from "mongoose";

const catalog = new Schema({
   image:{
    type:String,
   },
   description:{
    type:String,
   },
   price:{
    type:String,
   }
},{timestamps:true});

const catalogSchema = new Schema({
    userId:{
        type:String,
        required:true,
    },
    category:{
        type:String,
    },
    catalog:{
        type:[catalog]
    }
},{timestamps:true});

export default model('Catalog',catalogSchema);