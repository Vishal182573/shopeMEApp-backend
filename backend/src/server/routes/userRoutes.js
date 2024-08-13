import { Router } from "express";
import {
        resellerRegistration,resellerLogin,getReseller,
        updateReseller,resellerToReseller,consumerToReseller,
        getResellers
} from "../controllers/resellerController.js"
import {
        consumerRegistration,consumerLogin,getConsumer,
        updateConsumer,consumerToConsumer,resellerToConsumer,
        getConsumers
} from "../controllers/consumerController.js"

const router = Router();

router.post("/registerConsumer",consumerRegistration);
router.post("/loginConsumer",consumerLogin);
router.post("/registerReseller",resellerRegistration);
router.post("/loginReseller",resellerLogin);
router.post("/resellerToReseller",resellerToReseller);
router.post("/consumerToReseller",consumerToReseller);
router.post("/consumerToConsumer",consumerToConsumer);
router.post("/resellerToConsumer",resellerToConsumer);
router.post("/updateConsumer",updateConsumer);
router.post("/updateReseller",updateReseller);

router.get("/getConsumer",getConsumer);
router.get("/getConsumers",getConsumers);
router.get("/getResellers",getResellers);
router.get("/getReseller",getReseller);

export default router;