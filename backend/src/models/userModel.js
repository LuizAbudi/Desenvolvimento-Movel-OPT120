const connection = require('../database/connection');

class UserModel {
  executeQuery(sql, params) {
    return new Promise((resolve, reject) => {
      connection.query(sql, params, (err, res) => {
        if (err) {
          console.log("Erro ao executar a query", err, sql);
          reject(err);
        }
        console.log("Query executada com sucesso", res);
        resolve(res);
      });
    });
  }

  listUser() {
    const sql = 'SELECT * FROM users';
    return this.executeQuery(sql, []);
  }

  getByIdUser(id) {
    const sql = 'SELECT * FROM users WHERE id = ?';
    return this.executeQuery(sql, [id]);
  }

  createUser(newUser) {
    const sql = 'INSERT INTO users SET ?';
    return this.executeQuery(sql, [newUser]);
  }

  updateUser(newUser, id) {
    const sql = 'UPDATE users SET ? WHERE id = ?';
    return this.executeQuery(sql, [newUser, id]);
  }

  deleteUser(id) {
    const sql = 'DELETE FROM users WHERE id = ?';
    return this.executeQuery(sql, [id]);
  }

}

module.exports = new UserModel();