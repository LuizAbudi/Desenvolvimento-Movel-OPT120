const connection = require('../database/connection');

class ActivityModel {
  listActivities() {
    const sql = 'SELECT * FROM activities';
    return new Promise((resolve, reject) => {
      connection.query(sql, {}, (err, res) => {
        if (err) {
          console.log("Erro ao listar as atividades", err);
          reject(err);
        }
        console.log("Lista de atividades", res);
        resolve(res);
      });
    });
  }

  getById(id) {
    const sql = 'SELECT * FROM activities WHERE id = ?';
    return new Promise((resolve, reject) => {
      connection.query(sql, [id], (err, res) => {
        if (err) {
          console.log("Erro ao buscar a atividade", err);
          reject(err);
        }
        console.log("Atividade encontrada", res);
        resolve(res);
      });
    });
  }

  createActivities(newActivity) {
    const sql = 'INSERT INTO activities SET ?';
    return new Promise((resolve, reject) => {
      connection.query(sql, newActivity, (err, res) => {
        if (err) {
          console.log("Erro ao criar a atividade", err);
          reject(err);
        }
        console.log("Atividade criada com sucesso", res);
        resolve(res);
      });
    });
  }

  updateActivities(newActivity, id) {
    const sql = 'UPDATE activities SET ? WHERE id = ?';
    return new Promise((resolve, reject) => {
      connection.query(sql, [newActivity, id], (err, res) => {
        if (err) {
          console.log("Erro ao atualizar a atividade", err);
          reject(err);
        }
        console.log("Atividade atualizada com sucesso", res);
        resolve(res);
      });
    });
  }
}

module.exports = new ActivityModel();