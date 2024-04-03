const { Router } = require('express');
const router = Router();
const activityController = require('../controllers/activityController');

router.get('/activity', (req, res) => {
  const activities = activityController.getAllActivities();
  activities.then((activities) => res.status(200).json(activities)).catch((err) => res.status(400).json(err.message));
});

router.get('/activity/:id', (req, res) => {
  const { id } = req.params;
  const activities = activityController.getActivityById(id);
  activities.then((activity) => res.status(200).json(activity)).catch((err) => res.status(400).json(err.message));
});

router.post('/activity', (req, res) => {
  const newUser = req.body;
  const activities = activityController.create(newUser);
  activities.then((activity) => res.status(201).json(activity)).catch((err) => res.status(400).json(err.message));
});

router.put('/activity/:id', (req, res) => {
  const { id } = req.params;
  const newActivity = req.body;
  const activities = activityController.update(newActivity, id);
  activities.then((activity) => res.status(200).json(activity)).catch((err) => res.status(400).json(err.message));
});

router.delete('/activity/:id', (req, res) => {
  const { id } = req.params;
  const activities = activityController.delete(id);
  activities.then((activity) => res.status(200).json(activity)).catch((err) => res.status(400).json(err.message));
});

module.exports = router;