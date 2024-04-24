const userModel = require("../models/userModel");

class UserController {
  async getAllUsers(req, res) {
    const listUsers = userModel.listUser();
    try {
      const users = await listUsers;
      return res.status(200).json(users);
    } catch (err) {
      return res.status(400).json(err.message);
    }
  }

  async getUsersById(req, res) {
    const { id } = req.params;
    const users = userModel.getByIdUser(id);
    try {
      const user = await users;
      return res.status(200).json(user);
    } catch (err) {
      return res.status(400).json(err.message);
    }
  }

  async create(req, res) {
    const newUser = req.body;
    const users = userModel.createUser(newUser);
    try {
      const user = await users;
      return res.status(201).json(user);
    } catch (err) {
      return res.status(400).json(err.message);
    }
  }

  update(req, res) {
    const { id } = req.params;
    const newUser = req.body;
    const users = userModel.updateUser(newUser, id);
    users.then((user) => res.status(200).json(user)).catch((err) => res.status(400).json(err.message));
  }

  async delete(req, res) {
    const { id } = req.params;
    const users = userModel.deleteUser(id);
    try {
      const user = await users;
      return res.status(200).json(user);
    } catch (err) {
      return res.status(400).json(err.message);
    }
  }
}

module.exports = new UserController();