import Catalog from "../models/CatalogModel.js";
import Reseller from "../models/ResellerModel.js";
import asyncHandler from "express-async-handler";

// Upload a new catalog
const uploadCatalog = asyncHandler(async (req, res) => {
  try {
    const { userId, productName, category, description, price, images } =
      req.body;
    if (
      !userId ||
      !productName ||
      !description ||
      !price ||
      !images ||
      !category
    )
      return res.status(400).json({ message: "Bad Request" });
    const user = await Reseller.findById(userId);
    user.catalogueCount = user.catalogueCount + 1;
    await user.save();
    const newCatalog = new Catalog({
      userId,
      productName,
      category,
      description,
      price,
      images,
    });
    const savedCatalog = await newCatalog.save();
    res.status(200).json(savedCatalog);
  } catch (error) {
    res
      .status(500)
      .json({ error: "Error creating post", details: error.message });
  }
});

// Get all posts
const getAllCatalog = asyncHandler(async (req, res) => {
  try {
    const catalogs = await Catalog.find({});
    return res.status(200).json(catalogs);
  } catch (err) {
    return res.status(500).json({ message: "Internal server error" });
  }
});

// Get posts by category
const getCatalogsByCategory = asyncHandler(async (req, res) => {
  try {
    const { category } = req.query;
    if (!category) return res.status(400).json({ message: "Bad Request" });
    const catalogs = await Catalog.find({ category });
    res.status(200).json(catalogs);
  } catch (error) {
    res
      .status(500)
      .json({
        error: "Error fetching posts by category",
        details: error.message,
      });
  }
});

const getCatalogByUserId = asyncHandler(async (req, res) => {
  try {
    const { userId } = req.query;
    if (!userId) return res.status(400).json({ message: "UserId required" });
    const catalogs = await Catalog.find({ userId });
    if (!catalogs) {
      return res.status(404).json({ message: "Post not found" });
    }
    return res.status(200).json(catalogs);
  } catch (err) {
    return res.status(500).json({ message: "Internal Server Error" });
  }
});

const deleteCatalog = asyncHandler(async (req, res) => {
  try {
    const { id } = req.query;
    if (!id) {
      return res.status(400).json({ message: "Bad request: ID is necessary" });
    }
    const catalog = await Catalog.findById(id);
    if (!catalog) {
      return res.status(404).json({ message: "Catalog not found" });
    }
    const user = await Reseller.findById(catalog.userId);
    user.catalogueCount = user.catalogueCount - 1;
    await user.save();
    await catalog.deleteOne({ _id: id });
    return res.status(200).json({ message: "Catalog deleted successfully" });
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Internal server error", error: error.message });
  }
});

const searchCatalog = asyncHandler(async (req, res) => {
  try {
    const { prefix } = req.query;

    if (!prefix) {
      return res.status(400).json({ message: "Prefix parameter is required" });
    }

    // Create a case-insensitive regex pattern for the prefix
    const regex = new RegExp(prefix, 'i');

    // Find catalogs where productName or category matches the regex
    const catalogs = await Catalog.find({
      $or: [
        { productName: regex },
        { category: regex }
      ]
    });

    res.status(200).json(catalogs);
  } catch (error) {
    res.status(500).json({ error: "Error searching catalogs", details: error.message });
  }
});


export {
  uploadCatalog,
  deleteCatalog,
  getAllCatalog,
  getCatalogsByCategory,
  getCatalogByUserId,
  searchCatalog,
};
