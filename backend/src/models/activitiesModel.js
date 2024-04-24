const connection = require('../database/connection');

class ActivityModel {
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

  listActivities() {
    const sql = 'SELECT * FROM activities';
    return this.executeQuery(sql, []);
  }

  getById(id) {
    const sql = 'SELECT * FROM activities WHERE id = ?';
    return this.executeQuery(sql, [id]);
  }

  createActivities(newActivity) {
    const sql = 'INSERT INTO activities SET ?';
    return this.executeQuery(sql, [newActivity]).then(result => {
      return { id: result.insertId, ...newActivity };
    });
  }

  updateActivities(newActivity, id) {
    const sql = 'UPDATE activities SET ? WHERE id = ?';
    return this.executeQuery(sql, [newActivity, id]).then(() => {
      return { id, ...newActivity };
    });
  }

  deleteActivity(id) {
    const sql = 'DELETE FROM activities WHERE id = ?';
    return this.executeQuery(sql, [id]).then(result => {
      if (result.affectedRows > 0) {
        return { message: 'Atividade excluída com sucesso' };
      } else {
        return { error: 'Nenhuma atividade encontrada para o ID fornecido' };
      }
    });
  }
}

module.exports = new ActivityModel();