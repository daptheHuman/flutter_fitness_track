import User from "../models/User.js";
import bcrypt from "bcrypt";
import { generateToken, generateRefreshToken } from "./token.js";

const signUp = async (req, res) => {
  const { email, username, password } = req.body;
  const hashedPassword = await bcrypt.hashSync(password, 10);

  const user = new User({
    email: email,
    username: username,
    password: hashedPassword,
  });

  await user.save();
  return res.status(200).send({ message: "Successfully create a user" });
};

const signIn = async (req, res) => {
  const { email, password } = req.body;
  const user = await User.findOne({
    email: email,
  });

  console.log(user);

  if (!user) {
    return res.status(404).send({ message: "User not found!" });
  }

  const {
    routine,
    history,
    password: UserPass,
    email: userEmail,
    ...userWithoutPassword
  } = user._doc;

  const isPasswordValid = bcrypt.compareSync(password, user.password);

  if (!isPasswordValid) {
    return res.status(401).send({ message: "Password Invalid!" });
  }

  const token = await generateToken(user);
  const refreshToken = await generateRefreshToken(user);

  return res.status(200).send({
    accessToken: token,
    refreshToken: refreshToken,
    user: userWithoutPassword,
  });
};

const refreshToken = async (req, res) => {
  const newToken = await generateToken(req.user);

  return res.status(200).send({ newToken });
};

const Auth = {
  signIn,
  signUp,
  refreshToken,
};

export default Auth;
