import { Router } from "express";
import {userRegisteration,userLogin} from "../controllers/userControllers.js"

const router = Router();

router.post("/register",userRegisteration);
router.post("/login",userLogin);

export default router;