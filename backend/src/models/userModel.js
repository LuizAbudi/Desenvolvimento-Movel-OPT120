const connection = require('../database/connection');

class UserModel {
  listUser() {
    const sql = 'SELECT * FROM users';
    return new Promise((resolve, reject) => {
      connection.query(sql, {}, (err, res) => {
        if (err) {
          console.log("Erro ao listar os usuários", err);
          reject(err);
        }
        console.log("Lista de usuários", res);
        resolve(res);
      });
    });
  }

  getByIdUser(id) {
    const sql = 'SELECT * FROM users WHERE id = ?';
    return new Promise((resolve, reject) => {
      connection.query(sql, [id], (err, res) => {
        if (err) {
          console.log("Erro ao buscar o usuário", err);
          reject(err);
        }
        console.log("Usuário encontrado", res);
        resolve(res);
      });
    });
  }

  createUser(newUser) {
    const sql = 'INSERT INTO users SET ?';
    return new Promise((resolve, reject) => {
      connection.query(sql, newUser, (err, res) => {
        if (err) {
          console.log("Erro ao criar o usuário", err);
          reject(err);
        }
        console.log("Usuário criado com sucesso", res);
        resolve(res);
      });
    });
  }

  updateUser(newUser, id) {
    const sql = 'UPDATE users SET ? WHERE id = ?';
    return new Promise((resolve, reject) => {
      connection.query(sql, [newUser, id], (err, res) => {
        if (err) {
          console.log("Erro ao atualizar o usuário", err);
          reject(err);
        }
        console.log("Usuário atualizado com sucesso", res);
        resolve(res);
      });
    });
  }

  deleteUser(id) {
    const sql = 'DELETE FROM users WHERE id = ?';
    return new Promise((resolve, reject) => {
      connection.query(sql, [id], (err, res) => {
        if (err) {
          console.log("Erro ao deletar o usuário", err);
          reject(err);
        }
        console.log("Usuário deletado com sucesso", res);
        resolve(res);
      });
    });
  }

}

module.exports = new UserModel();