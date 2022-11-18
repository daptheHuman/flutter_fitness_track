import express from "express";
import { verifyToken } from "../middleware/token.js";
import User from "../models/User.js";
import routineController from "../controllers/routine.js";

const router = express.Router();

// CREATE
router.post("/", verifyToken, routineController.createRoutine);

// READ
router.get("/", verifyToken, routineController.getAllRoutines);

// FIND BY ID
router.get("/:id", verifyToken, routineController.getRoutine);

// UPDATE
router.put("/:id", verifyToken, routineController.updateRoutine);

export default router;
