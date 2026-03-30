const router = require('express').Router();
const { login, register, logout } = require('../controllers/authController');
const { validateLogin, validateRegister } = require('../middleware/validation');

router.post('/register', validateRegister, register);
router.post('/login',    validateLogin,    login);
router.post('/logout',                    logout);

module.exports = router;
