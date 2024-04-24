const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const UserController = require('./userController');
const userModel = require("../models/userModel");

async function login(req, res) {
  const { email, password } = req.body;

  const user = await userModel.getUserByEmail(email);
  if (!user) {
    return res.status(401).json({ message: "Usuário não encontrado" });
  }

  const passwordMatch = await bcrypt.compare(password, user.password);
  if (!passwordMatch) {
    return res.status(401).json({ message: "Senha incorreta" });
  }

  const token = jwt.sign({ userId: user.id }, 'password', { expiresIn: '1h' });

  res.json({ token });
}

module.exports = {
  login
};
