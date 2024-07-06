import express from 'express';
import { uploadPost, trendingPost, getPostByCategory, likePost, commentPost, getAllPosts } from '../controllers/postControllers.js';
import auth from "../middleware/authMiddleware.js"

const router = express.Router();

router.get('/trending',auth, trendingPost);
router.get('/category',auth, getPostByCategory);
router.get('/getAllPost',auth,getAllPosts);

router.post('/upload',auth,uploadPost);
router.post('/like',auth,likePost);
router.post('/comment',auth,commentPost);

export default router;
