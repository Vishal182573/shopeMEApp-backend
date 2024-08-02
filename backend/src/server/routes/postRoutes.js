import express from 'express';
import { uploadPost, trendingPost, getPostByCategory, likePost, commentPost, getAllPosts,getPostsByUserId, deletePost } from '../controllers/postControllers.js';
import auth from "../middleware/authMiddleware.js"

const router = express.Router();

router.get('/trending',trendingPost);
router.get('/category',getPostByCategory);
router.get('/getAllPost',getAllPosts);
router.get('/getPostByUserId',getPostsByUserId);
router.get('/deletePost',deletePost)

router.post('/upload',uploadPost);
router.post('/like',likePost);
router.post('/comment',commentPost);

export default router;
