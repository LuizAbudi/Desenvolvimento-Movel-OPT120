const { Router } = require('express');

const router = Router();
const userController = require('../../src/controllers/userController');

router.get('/user', (req, res) => {
  userController.getAllUsers(req, res);
});

router.get('/user/:id', (req, res) => {
  userController.getUsersById(req, res);
});

router.post('/user', (req, res) => {
  userController.create(req, res);
});

router.put('/user/:id', (req, res) => {
  userController.update(req, res);
});

router.delete('/user/:id', (req, res) => {
  userController.delete(req, res);
});

module.exports = router;