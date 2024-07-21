import { Router } from "express";
import {
        resellerRegistration,resellerLogin,getReseller,usersConnection,
        updateReseller
} from "../controllers/resellerController.js"
import {
        consumerRegistration,consumerLogin,getConsumer,
        updateConsumer
} from "../controllers/consumerController.js"
import auth from "../middleware/authMiddleware.js"

const router = Router();

router.post("/registerConsumer",consumerRegistration);
router.post("/loginConsumer",consumerLogin);
router.post("/registerReseller",resellerRegistration);
router.post("/loginReseller",resellerLogin);
router.post("/connect",usersConnection);
router.post("/updateConsumer",auth,updateConsumer);
router.post("/updateReseller",auth,updateReseller);

router.get("/getConsumer",auth,getConsumer);
router.get("/getReseller",auth,getReseller);

export default router;