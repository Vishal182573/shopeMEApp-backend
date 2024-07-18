import Post from '../models/PostModel.js';
import asyncHandler from "express-async-handler";

// Upload a new post
const uploadPost = asyncHandler(async (req, res) => {
    try {
        const { userid, userType, description, category, likes, comments, images } = req.body;
        if (!userid || !category || !userType) return res.status(400).json({ message: "Bad Request" });

        const newPost = new Post({
            userid,
            userType,
            description: description || "",
            category: category || "",
            likes: likes || [],
            comments: comments || [],
            images: images || []
        });
        const savedPost = await newPost.save();
        res.status(200).json(savedPost);
    } catch (error) {
        res.status(500).json({ error: 'Error creating post', details: error.message });
    }
});

// Get trending posts (ordered by number of likes and comments)
const trendingPost = asyncHandler(async (req, res) => {
    try {
        const sevenDaysAgo = new Date();
        sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);

        const trendingPosts = await Post.aggregate([
            {
                $match: {
                    $or: [
                        { 'likes.createdAt': { $gte: sevenDaysAgo } },
                        { 'comments.createdAt': { $gte: sevenDaysAgo } }
                    ]
                }
            },
            {
                $addFields: {
                    recentLikesCount: {
                        $size: {
                            $filter: {
                                input: '$likes',
                                as: 'like',
                                cond: { $gte: ['$$like.createdAt', sevenDaysAgo] }
                            }
                        }
                    },
                    recentCommentsCount: {
                        $size: {
                            $filter: {
                                input: '$comments',
                                as: 'comment',
                                cond: { $gte: ['$$comment.createdAt', sevenDaysAgo] }
                            }
                        }
                    }
                }
            },
            {
                $sort: {
                    recentLikesCount: -1,
                    recentCommentsCount: -1
                }
            }
        ]);

        res.status(200).json(trendingPosts);
    } catch (error) {
        res.status(500).json({ error: 'Error fetching trending posts', details: error.message });
    }
});

// Get posts by category
const getPostByCategory = asyncHandler(async (req, res) => {
    try {
        const { category } = req.query;
        if (!category) return res.status(400).json({ message: "Bad Request" });
        const posts = await Post.find({ category });
        res.status(200).json(posts);
    } catch (error) {
        res.status(500).json({ error: 'Error fetching posts by category', details: error.message });
    }
});

// Like a post
const likePost = asyncHandler(async (req, res) => {
    try {
        const { postid, userid,userType} = req.body;
        if (!postid || !userid || !userType) return res.status(400).json({ message: "Bad Request" });

        const post = await Post.findById(postid);
        if (!post) return res.status(404).json({ message: "Post not found" });

        const existingLike = post.likes.find(like => like.userId === userid);
        if (!existingLike) {
            post.likes.push({ userId: userid,userType, createdAt: new Date() });
            await post.save();
        }

        res.status(200).json(post);
    } catch (error) {
        res.status(500).json({ error: 'Error liking post', details: error.message });
    }
});

// Comment on a post
const commentPost = asyncHandler(async (req, res) => {
    try {
        const { postid, userid,userType, comment } = req.body;
        if (!postid || !userid || !userType || !comment) return res.status(400).json({ message: "Bad Request" });

        const post = await Post.findById(postid);
        if (!post) return res.status(404).json({ message: "Post not found" });

        post.comments.push({ userId: userid,userType, comment, createdAt: new Date() });
        await post.save();

        res.status(200).json(post);
    } catch (error) {
        res.status(500).json({ error: 'Error commenting on post', details: error.message });
    }
});

// Get all posts
const getAllPosts = asyncHandler(async (req, res) => {
    try {
        const posts = await Post.find({});
        return res.status(200).json(posts);
    } catch (err) {
        return res.status(500).json({ message: "Internal server error" });
    }
});

const getPostsByUserId = asyncHandler(async(req,res)=>{
    try{
        const {userId} = req.query;
        if(!userId) return res.status(400).json({message:"UserId required"});
        const posts = await Post.find({userid:userId});
        if(!posts){
          return res.status(404).json({message:"Post not found"});  
        }
        return res.status(200).json(posts);
    }catch(err){
        return res.status(500).json({message:"Internal Server Error"});
    }
})

export {
    uploadPost,
    trendingPost,
    getPostByCategory,
    likePost,
    commentPost,
    getPostsByUserId,
    getAllPosts,
};
