import mongoose from "mongoose";

const Schema = mongoose.Schema;

const ExerciseSchema = new Schema({
  name: { type: String, require: true },
  sets: { type: Number, default: 0 },
  reps: { type: Number, default: 0 },
});

const RoutineSchema = new Schema({
  name: { type: String, require: true },
  exercise: [ExerciseSchema],
});

const RoutineHistorySchema = new Schema({
  startDate: { type: Date, require: true },
  endDate: { type: Date, require: true },
  routineId: { type: Schema.Types.ObjectId, ref: "Routine", require: true },
  routine: [ExerciseSchema],
});

const Routine = mongoose.model("Routine", RoutineSchema);
const RoutineHistory = mongoose.model("History", RoutineHistorySchema);

export {
  Routine,
  RoutineHistory,
  RoutineSchema,
  RoutineHistorySchema,
  ExerciseSchema,
};
