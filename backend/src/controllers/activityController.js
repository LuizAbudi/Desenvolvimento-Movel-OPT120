const activityModel = require("../models/activityModel");

class ActivityController {
  getAllActivities() {
    return activityModel.listActivities();
  }

  getActivityById(id) {
    return activityModel.getById(id);
  }

  create(newActivity) {
    return activityModel.createActivities(newActivity);
  }

  update(newActivity, id) {
    return activityModel.createActivities(newActivity, id);
  }

  delete(id) {
    return activityModel.createActivities(id);
  }

}

module.exports = new ActivityController();