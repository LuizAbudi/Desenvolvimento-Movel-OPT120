const userActivities = require('../models/userActivitiesModel');

class UserActivitiesController {
  getAllUserActivities(req, res) {
    const user_activities = userActivities.listUserActivities();
    return user_activities.then((user_activities) => res.status(200).json(user_activities)).catch((err) => res.status(400).json(err.message));
  }

  create(req, res) {
    const newUserActivities = req.body;
    const user_activities = userActivities.createUserActivities(newUserActivities);
    return user_activities.then((user_activity) => res.status(201).json(user_activity)).catch((err) => res.status(400).json(err.message));
  }

  update(req, res) {
    const { id } = req.params;
    const newUserActivities = req.body;
    const user_activities = userActivities.updateUserActivities(newUserActivities, id);
    return user_activities.then((user_activity) => res.status(200).json(user_activity)).catch((err) => res.status(400).json(err.message));
  }

  delete(req, res) {
    const userAndActivityID = req.body;
    const user_activities = userActivities.deleteUserActivities(userAndActivityID);
    return user_activities.then((user_activity) => res.status(200).json(user_activity)).catch((err) => res.status(400).json(err.message));
  }
}

module.exports = new UserActivitiesController();