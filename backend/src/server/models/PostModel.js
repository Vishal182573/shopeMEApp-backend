import { Schema, model } from "mongoose";

const postSchema = new Schema({
    userid: {
        type: String,
        required: true,
    },
    description: {
        type: String,
    },
    likes: [{
        userId: {
            type: String,
            required: true,
        },
        createdAt: {
            type: Date,
            default: Date.now,
        }
    }],
    category: {
        type: String,
        required: true,
    },
    comments: [{
        userId: {
            type: String,
            required: true,
        },
        comment: {
            type: String,
            required: true,
        },
        createdAt: {
            type: Date,
            default: Date.now,
        }
    }],
    images: {
        type: [String],
    }
}, { timestamps: true });

export default model('Post', postSchema);
