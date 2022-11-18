import User from "../models/User.js";

const checkDuplicateUsernameOrEmail = async (req, res, next) => {
  // Username
  try {
    const username = await User.findOne({
      username: req.body.username,
    });

    if (username) {
      return res
        .status(403)
        .send({ message: "Failed! Username is already in use!" });
    }
  } catch (error) {
    return res.status(500);
  }

  // Email
  try {
    const email = await User.findOne({
      email: req.body.email,
    });

    if (email) {
      return res
        .status(403)
        .send({ message: "Failed! Email is already in use!" });
    }
  } catch (error) {
    return res.status(500);
  }

  next();
};

const verifySignUp = {
  checkDuplicateUsernameOrEmail,
};

export default verifySignUp;
