import { Router } from "express";
import {
        resellerRegistration,resellerLogin,getReseller,
        updateReseller,resellerToReseller,consumerToReseller
} from "../controllers/resellerController.js"
import {
        consumerRegistration,consumerLogin,getConsumer,
        updateConsumer,consumerToConsumer,resellerToConsumer
} from "../controllers/consumerController.js"
import auth from "../middleware/authMiddleware.js"

const router = Router();

router.post("/registerConsumer",consumerRegistration);
router.post("/loginConsumer",consumerLogin);
router.post("/registerReseller",resellerRegistration);
router.post("/loginReseller",resellerLogin);
router.post("/resellerToReseller",resellerToReseller);
router.post("/consumerToReseller",consumerToReseller);
router.post("/consumerToConsumer",consumerToConsumer);
router.post("/resellerToConsumer",resellerToConsumer);
router.post("/updateConsumer",auth,updateConsumer);
router.post("/updateReseller",auth,updateReseller);

router.get("/getConsumer",getConsumer);
router.get("/getReseller",getReseller);

export default router;