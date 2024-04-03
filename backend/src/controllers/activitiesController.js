const activityModel = require("../models/activitiesModel");

class ActivityController {
  getAllActivities(req, res) {
    const activities = activityModel.listActivities();
    return activities.then((activities) => res.status(200).json(activities)).catch((err) => res.status(400).json(err.message));
  }

  getActivityById(req, res) {
    const { id } = req.params;
    const activities = activityModel.getById(id);
    return activities.then((activity) => res.status(200).json(activity)).catch((err) => res.status(400).json(err.message));
  }

  create(req, res) {
    const newUser = req.body;
    const activities = activityModel.createActivities(newUser);
    return activities.then((activity) => res.status(201).json(activity)).catch((err) => res.status(400).json(err.message));
  }

  update(req, res) {
    const { id } = req.params;
    const newActivity = req.body;
    const activities = activityModel.updateActivities(newActivity, id);
    return activities.then((activity) => res.status(200).json(activity)).catch((err) => res.status(400).json(err.message));
  }

  delete(req, res) {
    const { id } = req.params;
    const activities = activityModel.deleteActivity(id);
    return activities.then((activity) => res.status(200).json(activity)).catch((err) => res.status(400).json(err.message));
  }

}

module.exports = new ActivityController();