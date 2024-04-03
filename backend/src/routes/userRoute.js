const { Router } = require('express');

const router = Router();
const userController = require('../../src/controllers/userController');

router.get('/user', (req, res) => {
  const listUsers = userController.getAllUsers();
  listUsers.then((users) => res.status(200).json(users)).catch((err) => res.status(400).json(err.message));
});

router.get('/user/:id', (req, res) => {
  const { id } = req.params;
  const users = userController.getUsersById(id);
  users.then((user) => res.status(200).json(user)).catch((err) => res.status(400).json(err.message));
});

router.post('/user', (req, res) => {
  const newUser = req.body;
  const users = userController.create(newUser);
  users.then((user) => res.status(201).json(user)).catch((err) => res.status(400).json(err.message));
});

router.put('/user/:id', (req, res) => {
  const { id } = req.params;
  const newUser = req.body;
  const users = userController.update(newUser, id);
  users.then((user) => res.status(200).json(user)).catch((err) => res.status(400).json(err.message));
});

router.delete('/user/:id', (req, res) => {
  const { id } = req.params;
  const users = userController.delete(id);
  users.then((user) => res.status(200).json(user)).catch((err) => res.status(400).json(err.message));
});

module.exports = router;