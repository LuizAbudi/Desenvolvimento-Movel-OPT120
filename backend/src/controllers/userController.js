const userModel = require("../models/userModel");

class UserController {
  getAllUsers() {
    return userModel.listUser();
  }

  getUsersById(id) {
    return userModel.getByIdUser(id);
  }

  create(newUser) {
    return userModel.createUser(newUser);
  }

  update(newUser, id) {
    return userModel.updateUser(newUser, id);
  }

  delete(id) {
    return userModel.deleteUser(id);
  }

}

module.exports = new UserController();