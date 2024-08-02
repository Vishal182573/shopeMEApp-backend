import express from 'express';
import { uploadCatalog,deleteCatalog,getAllCatalog, getCatalogsByCategory, getCatalogByUserId,searchCatalog } from '../controllers/catalogController.js';
import auth from "../middleware/authMiddleware.js"

const router = express.Router();

router.post('/uploadCatalog',uploadCatalog);

router.get('/deleteCatalog',deleteCatalog);
router.get('/getCatalogsByCategory',getCatalogsByCategory);
router.get('/getAllCatalogs',getAllCatalog);
router.get('/getAllByUserId',getCatalogByUserId);
router.get('/searchCatalog', searchCatalog); 

export default router;
