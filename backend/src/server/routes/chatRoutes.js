import { Router } from "express";
import {addChat,updateChat} from "../controllers/chatControllers.js"
import auth from "../middleware/authMiddleware.js";
const router = Router();

router.post('/addChat',auth,addChat); // use to create new chat between userId1 and userId2
router.post('/updateChat',auth,updateChat); // userId1 is the sender and userId2 is the reciever, while sending request send sender userId first and after adding message to chat it will return updated chat
export default router;