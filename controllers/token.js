import jwt from 'jsonwebtoken';
import 'dotenv/config';

const SECRET_KEY = process.env.JWT_SECRET;
const REFRESH_SECRET_KEY = process.env.JWT_REFRESH_SECRET;

const generateToken = async (user) => {
	const { username, _id } = user;
	return await jwt.sign({ username: username, _id: _id }, SECRET_KEY, {
		expiresIn: '5d',
	});
};

const generateRefreshToken = async (user) => {
	const { username, _id } = user;
	return await jwt.sign({ username: username, _id: _id }, REFRESH_SECRET_KEY, {
		expiresIn: '30d',
	});
};

export { generateToken, generateRefreshToken };
