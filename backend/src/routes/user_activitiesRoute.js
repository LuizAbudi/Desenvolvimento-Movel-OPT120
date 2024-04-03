const { Router } = require('express');
const router = Router();
const user_activityController = require('../controllers/userActivitiesController');

router.get('/user_activity', (req, res) => {
  user_activityController.getAllUserActivities(req, res);
});

router.post('/user_activity', (req, res) => {
  user_activityController.create(req, res);
});

router.put('/user_activity/:id', (req, res) => {
  user_activityController.updade(req, res);
});

router.delete('/user_activity/', (req, res) => {
  user_activityController.delete(req, res);
});

module.exports = router;