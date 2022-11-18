import jwt from "jsonwebtoken";
import "dotenv/config";

const SECRET_KEY = process.env.JWT_SECRET;
const REFRESH_SECRET_KEY = process.env.JWT_REFRESH_SECRET;

const verifyToken = async (req, res, next) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];

  if (!token) {
    return res.status(406);
  }

  try {
    const user = await jwt.verify(token, SECRET_KEY);
    req.user = user;
    next();
  } catch (error) {
    return res.status(403).send({ message: "Invalid Token" });
  }
};

const verifyRefreshToken = async (req, res, next) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];
  const refreshToken = req.body.refreshToken;
  console.log(token, refreshToken);

  if (!token) {
    return res.status(406);
  }

  try {
    const user = await jwt.verify(token, SECRET_KEY);
    const newRefreshToken = await jwt.verify(refreshToken, REFRESH_SECRET_KEY);

    if (user._id === newRefreshToken._id) {
      req.user = user;
      next();
    } else throw new Error();
  } catch (error) {
    console.log(error);
    return res.status(403).send({ message: "Invalid Token" });
  }
};

export { verifyToken, verifyRefreshToken };
