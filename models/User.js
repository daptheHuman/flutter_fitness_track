import mongoose from "mongoose";

const Schema = mongoose.Schema;

const UserSchema = new Schema({
  username: { type: String, require: true },
  email: { type: String, require: true },
  password: { type: String, require: true },
  routine: [
    {
      type: Schema.Types.ObjectId,
      ref: "Routine",
    },
  ],
  history: [
    {
      type: Schema.Types.ObjectId,
      ref: "History",
    },
  ],
});

const User = mongoose.model("Users", UserSchema);

export default User;
