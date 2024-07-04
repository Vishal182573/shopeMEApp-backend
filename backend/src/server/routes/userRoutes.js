import { Router } from "express";
import {
        resellerRegistration,resellerLogin,getReseller
} from "../controllers/resellerController.js"
import {
        consumerRegistration,consumerLogin,getConsumer
} from "../controllers/consumerController.js"
import auth from "../middleware/authMiddleware.js"

const router = Router();

router.post("/registerConsumer",consumerRegistration);
router.post("/loginConsumer",consumerLogin);
router.post("/registerReseller",resellerRegistration);
router.post("/loginReseller",resellerLogin);

router.get("/getConsumer",auth,getConsumer);
router.get("/getReseller",auth,getReseller);

export default router;