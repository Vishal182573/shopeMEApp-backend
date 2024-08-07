import { Router } from "express";
import {
    postRequirements,
    showAllRequirements,
    getRequirementByCategory,
    deleteRequirement,
    searchrequirement,
    getRequirementByUserId
} from "../controllers/requirementsControllers.js"
import auth from "../middleware/authMiddleware.js"

const router = Router();

router.post("/postRequirement",auth,postRequirements);

router.get("/getAllRequirements",showAllRequirements);
router.get("/getRequirementsByCategory",auth,getRequirementByCategory),
router.get("/deleteRequirement",auth,deleteRequirement);
router.get("/searchRequirement",searchrequirement);
router.get("/getReqByUserid",getRequirementByUserId);


export default router;