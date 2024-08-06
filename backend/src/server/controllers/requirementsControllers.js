import Requirement from "../models/RequirementModel.js";
import asyncHandler from "express-async-handler";

const postRequirements = asyncHandler(async (req, res) => {
  try {
    const {
      userId,
      userType,
      productName,
      category,
      quantity,
      totalPrice,
      details,
      images,
    } = req.body;

    if (!userId || !userType ||  !productName || !category || !quantity || !totalPrice) {
      return res.status(400).json({ message: "Bad request: Missing required fields" });
    }

    const requirement = new Requirement({
      userId,
      userType,
      productName,
      category,
      quantity,
      totalPrice,
      details: details || "",
      images: images || [""],
    });

    const savedRequirement = await requirement.save();
    return res.status(200).json({ message: "Requirement saved successfully", requirement: savedRequirement });

  } catch (error) {
    return res.status(500).json({ message: "Server error", error: error.message });
  }
});

const showAllRequirements = asyncHandler(async (req, res) => {
  try {
    const requirements = await Requirement.find({});
    return res.status(200).json(requirements);
  } catch (error) {
    return res.status(500).json({ message: "Server error", error: error.message });
  }
});

const getRequirementByCategory = asyncHandler(async (req, res) => {
  try {
    const { category } = req.query;
    if (!category) {
      return res.status(400).json({ message: "Bad request: Category needed" });
    }
    const requirements = await Requirement.find({ category });
    return res.status(200).json(requirements);

  } catch (error) {
    return res.status(500).json({ message: "Server error", error: error.message });
  }
});

const deleteRequirement = asyncHandler(async (req, res) => {
  try {
    const { id } = req.query;
    if (!id) {
      return res.status(400).json({ message: "Bad request: ID is necessary" });
    }

    const requirement = await Requirement.findById(id);
    if (!requirement) {
      return res.status(404).json({ message: "Requirement not found" });
    }

    await Requirement.deleteOne({ _id: id });
    return res.status(200).json({ message: "Requirement deleted successfully" });

  } catch (error) {
    return res.status(500).json({ message: "Internal server error", error: error.message });
  }
});



const searchrequirement = asyncHandler(async (req, res) => {
  try {
    const { prefix } = req.query;

    if (!prefix) {
      return res.status(400).json({ message: "Prefix parameter is required" });
    }

    // Create a case-insensitive regex pattern for the prefix
    const regex = new RegExp(prefix, 'i');

    // Find catalogs where productName or category matches the regex
    const catalogs = await Requirement.find({
      $or: [
        { productNam: regex },
        { category: regex }
      ]
    });

    res.status(200).json(catalogs);
  } catch (error) {
    res.status(500).json({ error: "Error searching requirement..",
       details: error.message });
  }
});











export {
  postRequirements,
  showAllRequirements,
  getRequirementByCategory,
  deleteRequirement,
  searchrequirement,
};
