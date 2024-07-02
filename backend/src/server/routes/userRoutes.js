import { Router } from "express";
import {userRegistration,
        userLogin,
        getUser,        
} from "../controllers/userControllers.js"

const router = Router();

router.post("/register",userRegistration);
router.post("/login",userLogin);

router.get("/getUser",getUser);

export default router;