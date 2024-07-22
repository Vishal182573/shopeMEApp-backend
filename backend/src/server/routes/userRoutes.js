import { Router } from "express";
import {
        resellerRegistration,resellerLogin,getReseller,usersConnection
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
router.post("/connect",usersConnection);

router.get("/getConsumer",getConsumer);
router.get("/getReseller",getReseller);

export default router;