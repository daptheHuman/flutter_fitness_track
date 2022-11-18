import express from 'express';
import Auth from '../controllers/auth.js';
import verifySignUp from '../middleware/users.js';
import { verifyRefreshToken } from '../middleware/token.js';
const router = express.Router();

router.post('/signin', Auth.signIn);
router.post('/signup', verifySignUp.checkDuplicateUsernameOrEmail, Auth.signUp);
router.post('/refresh', verifyRefreshToken, Auth.refreshToken);

export default router;
