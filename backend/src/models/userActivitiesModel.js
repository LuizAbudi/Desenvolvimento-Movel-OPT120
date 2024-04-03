const connection = require('../database/connection');

class UserActivitiesModel {
  listUserActivities() {
    const sql = 'SELECT * FROM user_activities';
    return new Promise((resolve, reject) => {
      connection.query(sql, {}, (err, res) => {
        if (err) {
          console.log("Erro ao listar as atividades dos usuários", err);
          reject(err);
        }
        console.log("Lista de atividades dos usuários", res);
        resolve(res);
      });
    });
  }

  getByIdUserActivities(id) {
    const sql = 'SELECT * FROM user_activities WHERE id = ?';
    return new Promise((resolve, reject) => {
      connection.query(sql, [id], (err, res) => {
        if (err) {
          console.log("Erro ao buscar a atividade do usuário", err);
          reject(err);
        }
        console.log("Atividade do usuário encontrada", res);
        resolve(res);
      });
    });
  }

  createUserActivities(newUserActivities) {
    const sql = 'INSERT INTO user_activities SET ?';
    return new Promise((resolve, reject) => {
      connection.query(sql, newUserActivities, (err, res) => {
        if (err) {
          console.log("Erro ao criar a atividade do usuário", err);
          reject(err);
        }
        console.log("Atividade do usuário criada com sucesso", res);
        resolve(res);
      });
    });
  }

  updateUserActivities(newUserActivities, id) {
    const sql = 'UPDATE user_activities SET ? WHERE id = ?';
    return new Promise((resolve, reject) => {
      connection.query(sql, [newUserActivities, id], (err, res) => {
        if (err) {
          console.log("Erro ao atualizar a atividade do usuário", err);
          reject(err);
        }
        console.log("Atividade do usuário atualizada com sucesso", res);
        resolve(res);
      });
    });
  }

  deleteUserActivities(id) {
    const sql = 'DELETE FROM user_activities WHERE id = ?';
    return new Promise((resolve, reject) => {
      connection.query(sql, [id], (err, res) => {
        if (err) {
          console.log("Erro ao deletar a atividade do usuário", err);
          reject(err);
        }
        console.log("Atividade do usuário deletada com sucesso", res);
        resolve(res);
      });
    });
  }

}

module.exports = new UserActivitiesModel();