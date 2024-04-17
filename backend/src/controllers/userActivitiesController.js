const userActivities = require('../models/userActivitiesModel');

class UserActivitiesController {
  async getAllUserActivities(req, res) {
    const user_activities = userActivities.listUserActivities();
    try {
      const user_activities_1 = await user_activities;
      return res.status(200).json(user_activities_1);
    } catch (err) {
      return res.status(400).json(err.message);
    }
  }

  async create(req, res) {
    const newUserActivities = req.body;

    if (typeof newUserActivities.score !== 'number' || newUserActivities.score < 0 || newUserActivities.score > 10) {
      return res.status(400).json({ error: 'O score deve ser um número entre 0 e 10.' });
    }

    const user_activities = userActivities.createUserActivities(newUserActivities);
    try {
      const user_activity = await user_activities;
      return res.status(201).json(user_activity);
    } catch (err) {
      return res.status(400).json(err.message);
    }
  }

  async update(req, res) {
    const { userId, activityId } = req.params;
    const newUserActivities = req.body;

    if (typeof newUserActivities.score !== 'number' || newUserActivities.score < 0 || newUserActivities.score > 10) {
      return res.status(400).json({ error: 'O score deve ser um número entre 0 e 10.' });
    }

    const user_activities = userActivities.updateUserActivities(newUserActivities, userId, activityId);
    try {
      const user_activity = await user_activities;
      return res.status(200).json(user_activity);
    } catch (err) {
      return res.status(400).json(err.message);
    }
  }

  async delete(req, res) {
    const userAndActivityID = req.body;
    const user_activities = userActivities.deleteUserActivities(userAndActivityID);
    try {
      const user_activity = await user_activities;
      return res.status(200).json(user_activity);
    } catch (err) {
      return res.status(400).json(err.message);
    }
  }
}

module.exports = new UserActivitiesController();