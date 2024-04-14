const { Router } = require('express');

const router = Router();
const userController = require('../../src/controllers/userController');

router.get('/users', (req, res) => {
  userController.getAllUsers(req, res);
});

router.get('/users/:id', (req, res) => {
  userController.getUsersById(req, res);
});

router.post('/users', (req, res) => {
  userController.create(req, res);
});

router.put('/users:id', (req, res) => {
  userController.update(req, res);
});

router.delete('/users/:id', (req, res) => {
  userController.delete(req, res);
});

module.exports = router;