const connection = require('../database/connection');
const bcrypt = require('bcrypt');
const saltRounds = 10;

class UserModel {
  executeQuery(sql, params) {
    return new Promise((resolve, reject) => {
      connection.query(sql, params, (err, res) => {
        if (err) {
          console.log("Erro ao executar a query", err, sql);
          reject(err);
        }
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

  async createUser(newUser) {
    const hashedPassword = await bcrypt.hash(newUser.password, saltRounds);
    newUser.password = hashedPassword;

    const sql = 'INSERT INTO users SET ?';
    return this.executeQuery(sql, [newUser]).then((res) => {
      return { id: res.insertId, ...newUser };
    });
  }

  async updateUser(newUser, id) {
    const sql = 'UPDATE users SET ? WHERE id = ?';
    await this.executeQuery(sql, [newUser, id]);
    return { id, ...newUser };
  }

  async deleteUser(id) {
    const sql = 'DELETE FROM users WHERE id = ?';
    await this.executeQuery(sql, [id]);
    return { id };
  }

  async getUserByEmail(email) {
    const sql = 'SELECT * FROM users WHERE email = ?';
    const result = await this.executeQuery(sql, [email]);
    return result[0];
  }

}

module.exports = new UserModel();