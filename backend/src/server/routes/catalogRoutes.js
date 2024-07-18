import express from 'express';
import { uploadCatalog,deleteCatalog,getAllCatalog, getCatalogsByCategory } from '../controllers/catalogController.js';
import auth from "../middleware/authMiddleware.js"

const router = express.Router();

router.post('/uploadCatalog',auth,uploadCatalog);

router.get('/deleteCatalog',auth,deleteCatalog);
router.get('/getCatalogsByCategory',auth,getCatalogsByCategory);
router.get('/getAllCatalogs',auth,getAllCatalog);

export default router;
