import { Router } from "express";
import {
    postRequirements,
    showAllRequirements,
    getRequirementByCategory,
    deleteRequirement
} from "../controllers/requirementsControllers.js"
import auth from "../middleware/authMiddleware.js"

const router = Router();

router.post("/postRequirement",auth,postRequirements);

router.get("/getAllRequirements",auth,showAllRequirements);
router.get("/getRequirementsByCategory",auth,getRequirementByCategory),
router.get("/deleteRequirement",auth,deleteRequirement);

export default router;