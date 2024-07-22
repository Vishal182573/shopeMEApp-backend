import express from 'express';
import { uploadPost, trendingPost, getPostByCategory, likePost, commentPost, getAllPosts,getPostsByUserId } from '../controllers/postControllers.js';
import auth from "../middleware/authMiddleware.js"

const router = express.Router();

router.get('/trending', trendingPost);
router.get('/category',auth, getPostByCategory);
router.get('/getAllPost',getAllPosts);
router.get('/getPostByUserId',auth,getPostsByUserId);

router.post('/upload',auth,uploadPost);
router.post('/like',auth,likePost);
router.post('/comment',auth,commentPost);

export default router;
