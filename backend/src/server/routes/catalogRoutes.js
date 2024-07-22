import express from 'express';
import { uploadCatalog,deleteCatalog,getAllCatalog, getCatalogsByCategory, getCatalogByUserId } from '../controllers/catalogController.js';
import auth from "../middleware/authMiddleware.js"

const router = express.Router();

router.post('/uploadCatalog',auth,uploadCatalog);

router.get('/deleteCatalog',auth,deleteCatalog);
router.get('/getCatalogsByCategory',auth,getCatalogsByCategory);
router.get('/getAllCatalogs',auth,getAllCatalog);
router.get('/getAllByUserId',auth,getCatalogByUserId)

export default router;
