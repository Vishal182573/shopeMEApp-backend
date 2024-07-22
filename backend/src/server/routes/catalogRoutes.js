import express from 'express';
import { uploadCatalog,deleteCatalog,getAllCatalog, getCatalogsByCategory } from '../controllers/catalogController.js';
import auth from "../middleware/authMiddleware.js"

const router = express.Router();

router.post('/uploadCatalog',uploadCatalog);

router.get('/deleteCatalog',deleteCatalog);
router.get('/getCatalogsByCategory',getCatalogsByCategory);
router.get('/getAllCatalogs',getAllCatalog);

export default router;
