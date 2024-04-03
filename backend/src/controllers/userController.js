const userModel = require("../models/userModel");

class UserController {
  getAllUsers(req, res) {
    const listUsers = userModel.listUser();
    return listUsers.then((users) => res.status(200).json(users)).catch((err) => res.status(400).json(err.message));
  }

  getUsersById(req, res) {
    const { id } = req.params;
    const users = userModel.getByIdUser(id);
    return users.then((user) => res.status(200).json(user)).catch((err) => res.status(400).json(err.message));
  }

  create(req, res) {
    const newUser = req.body;
    const users = userModel.createUser(newUser);
    return users.then((user) => res.status(201).json(user)).catch((err) => res.status(400).json(err.message));
  }

  update(req, res) {
    const { id } = req.params;
    const newUser = req.body;
    const users = userModel.updateUser(newUser, id);
    users.then((user) => res.status(200).json(user)).catch((err) => res.status(400).json(err.message));
  }

  delete(req, res) {
    const { id } = req.params;
    const users = userModel.deleteUser(id);
    return users.then((user) => res.status(200).json(user)).catch((err) => res.status(400).json(err.message));
  }

}

module.exports = new UserController();