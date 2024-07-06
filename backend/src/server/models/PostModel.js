import { Schema,model } from "mongoose";

const postSchema = new Schema({
    userid:{
        type:String,
        required:true,
    },
    description:{
        type:String,
    },
    likes:{
        type:[String], // contains user id who like that particular post
    },
    category:{
        type:String,
        required:true,
    },
    comments:{
        type:[String]
    },
    images:{ // store images from image routes one by one then store store url of each here
        type:[String],
    }
},{timestamps:true});

export default model('Post',postSchema);