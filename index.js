//import express
import express from "express";
import mongoose from "mongoose";
import cors from "cors";
import * as dotenv from "dotenv"; // see https://github.com/motdotla/dotenv#how-do-i-use-dotenv-with-import
import auth from "./routes/auth.js";
import routine from "./routes/routine.js";
import history from "./routes/history.js";

dotenv.config();
const app = express();
app.use(cors());
app.use(express.json());
const PORT = 3000;

try {
  await mongoose.connect(process.env.MONGODB);
  console.log("Database connected to MongoDB");
} catch (error) {
  console.log("Database not connected");
}

app.listen(process.env.PORT || PORT, () => {
  return console.log(`Server run on http://localhost:${PORT}`);
});

app.get("/api/", (req, res) => {
  return res.send();
});

app.use("/auth", auth);
app.use("/routine", routine);
app.use("/history", history);

export default app;
