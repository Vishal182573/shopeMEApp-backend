import { Router } from "express";
import {addChat,chatPreviews,markMessagesAsRead} from "../controllers/chatControllers.js"
import auth from "../middleware/authMiddleware.js";
const router = Router();

router.post('/addChat',addChat); // use to create new chat between userId1 and userId2
router.get('/ChatPreview',chatPreviews);// userId1 is the sender and userId2 is the reciever, while sending request send sender userId first and after adding message to chat it will return updated chat
router.get('/Markasread',markMessagesAsRead);
export default router;