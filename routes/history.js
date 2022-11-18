import express from "express";
import historyController from "../controllers/history.js";
import { verifyToken } from "../middleware/token.js";
const router = express.Router();

router.post("/", verifyToken, historyController.updateHistory);
router.get("/:userId", verifyToken, historyController.getAllHistory);
router.get(
  "/routine/:routineId/:userId",
  verifyToken,
  historyController.getRoutineHistory
);

export default router;
