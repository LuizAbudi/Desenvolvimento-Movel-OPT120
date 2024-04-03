const userActivities = require('../models/userActivitiesModel');

class UserActivitiesController {
  getAllUserActivities() {
    return userActivities.listUserActivities();
  }

  getUserActivityById(id) {
    return userActivities.getByIdUserActivities(id);
  }

  create(newUserActivities) {
    return userActivities.createUserActivities(newUserActivities);
  }

  update(newUserActivities, id) {
    return userActivities.updateUserActivities(newUserActivities, id);
  }

  delete(id) {
    return userActivities.deleteUserActivities(id);
  }
}

module.exports = new UserActivitiesController();