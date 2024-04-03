const { Router } = require('express');
const router = Router();
const activityController = require('../controllers/activitiesController');

router.get('/activity', (req, res) => {
  activityController.getAllActivities(req, res);
});

router.get('/activity/:id', (req, res) => {
  activityController.getActivityById(req, res);
});

router.post('/activity', (req, res) => {
  activityController.create(req, res);
});

router.put('/activity/:id', (req, res) => {
  activityController.update(req, res);
});

router.delete('/activity/:id', (req, res) => {
  activityController.delete(req, res);
});

module.exports = router;