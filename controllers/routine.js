import User from "../models/User.js";
import { Routine } from "../models/Routine.js";

const createRoutine = async (req, res) => {
  try {
    const user = await User.findById(req.user._id);
    const routine = new Routine(req.body);

    console.log("req.body", req.body);

    routine.save();
    user.routine.push(routine);
    user.save();

    return res.status(200).send({ message: "Routine created successfully" });
  } catch (error) {
    console.log("error", error);
    return res.status(500).send({ message: error.message });
  }
};

const getAllRoutines = async (req, res) => {
  try {
    const user = await User.findById(req.user._id).populate("routine");
    res.status(200).send(user.routine);
  } catch (error) {
    console.log("error", error);
    return res.status(500).send({ message: error.message });
  }
};

const getRoutine = async (req, res) => {
  const { _id } = req.user;
  const { id: routineId } = req.params;
  console.log("id", routineId);

  try {
    const routine = await User.findById(_id, {
      //  find UserRoutine schema in array of userRoutine
      routine: routineId,
    }).populate("routine");

    res.status(200).send(routine);
  } catch (error) {
    console.log("error", error);
    return res.status(500).send({ message: error.message });
  }
};

const updateRoutine = async (req, res) => {
  console.log("req.body", req.body);
  console.log("req.params", req.params);
  try {
    const routine = await Routine.findOne({
      routine: req.params.id,
    });

    routine.overwrite(req.body);
    routine.save();

    res.status(200).send(routine);
  } catch (error) {
    console.log("error", error);
    res.status(500).send({ message: error.message });
  }
};

const routineController = {
  createRoutine,
  getAllRoutines,
  getRoutine,
  updateRoutine,
};

export default routineController;
