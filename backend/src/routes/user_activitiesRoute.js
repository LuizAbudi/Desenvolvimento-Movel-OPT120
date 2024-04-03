const { Router } = require('express');
const router = Router();
const user_activityController = require('../controllers/userActivitiesController');

router.get('/user_activity', (req, res) => {
  const user_activities = user_activityController.getAllUserActivities();
  user_activities.then((user_activities) => res.status(200).json(user_activities)).catch((err) => res.status(400).json(err.message));
});

router.get('/user_activity/:id', (req, res) => {
  const { id } = req.params;
  const user_activities = user_activityController.getUserActivityById(id);
  user_activities.then((user_activity) => res.status(200).json(user_activity)).catch((err) => res.status(400).json(err.message));
});

router.post('/user_activity', (req, res) => {
  const newUserActivities = req.body;
  const user_activities = user_activityController.create(newUserActivities);
  user_activities.then((user_activity) => res.status(201).json(user_activity)).catch((err) => res.status(400).json(err.message));
});

router.put('/user_activity/:id', (req, res) => {
  const { id } = req.params;
  const newUserActivities = req.body;
  const user_activities = user_activityController.update(newUserActivities, id);
  user_activities.then((user_activity) => res.status(200).json(user_activity)).catch((err) => res.status(400).json(err.message));
});

router.delete('/user_activity/:id', (req, res) => {
  const { id } = req.params;
  const user_activities = user_activityController.delete(id);
  user_activities.then((user_activity) => res.status(200).json(user_activity)).catch((err) => res.status(400).json(err.message));
});

module.exports = router;