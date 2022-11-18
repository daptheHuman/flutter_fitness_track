import User from "../models/User.js";
import { Routine, RoutineHistory } from "../models/Routine.js";

const addHistory = async (req, res) => {
  const {
    _id: userId,
    routineId,
    routine: updatedRoutine,
    startDate,
    endDate,
  } = req.body;

  if (userId !== req.user._id) {
    // Unauthorized
    return res.status(400).send({ message: "Unauthorized" });
  }

  try {
    const user = await User.findOne({
      _id: userId,
    });

    const routineContext = await Routine.findOne({
      _id: routineId,
    });

    const history = new RoutineHistory({
      routineId: routineContext,
      startDate: startDate,
      endDate: endDate,
      routine: updatedRoutine,
    });

    await history.save();
    user.history.push(history);
    await (await user.save()).populate("history");

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    if (!history) {
      return res.status(404).json({ message: "Routine not found" });
    }

    return res.status(200).json({ message: "History added" });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

const getAllHistory = async (req, res) => {
  const { userId } = req.params;

  if (userId !== req.user._id) {
    // Unauthorized
    return res.status(400).send({ message: "Unauthorized" });
  }

  try {
    const user = await User.findOne({
      _id: userId,
    }).populate("history");

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    return res.status(200).json(user.history);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

const getRoutineHistory = async (req, res) => {
  const { routineId, userId } = req.params;

  if (userId !== req.user._id) {
    console.log("Unauthorized", userId, req.user._id);
    // Unauthorized
    return res.status(400).send({ message: "Unauthorized" });
  }

  try {
    const history = await RoutineHistory.find({ routineId: routineId });

    return res.status(200).send(history);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

const historyController = {
  updateHistory: addHistory,
  getAllHistory,
  getRoutineHistory,
};

export default historyController;
