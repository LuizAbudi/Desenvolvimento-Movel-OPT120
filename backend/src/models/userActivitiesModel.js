const connection = require('../database/connection');

class UserActivitiesModel {
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

  listUserActivities() {
    const sql = 'SELECT * FROM user_activities';
    return this.executeQuery(sql, []);
  }

  createUserActivities(newUserActivities) {
    const sql = 'INSERT INTO user_activities SET ?';
    return this.executeQuery(sql, [newUserActivities]);
  }

  updateUserActivities(newUserActivities, userId, activityId) {
    const sql = 'UPDATE user_activities SET delivery_date = ?, score = ? WHERE user_id = ? AND activity_id = ?';
    return this.executeQuery(sql, [newUserActivities.delivery_date, newUserActivities.score, userId, activityId]);
  }

  deleteUserActivities(userAndActivityID) {
    const sql = 'DELETE FROM user_activities WHERE user_id = ? AND activity_id = ?';
    return new Promise((resolve, reject) => {
      this.executeQuery(sql, [userAndActivityID.user_id, userAndActivityID.activity_id])
        .then(result => {
          if (result.affectedRows > 0) {
            resolve({ message: 'Atividade do aluno excluída com sucesso' });
          } else {
            reject({ error: 'Nenhuma atividade encontrada para o usuário e atividade fornecidos' });
          }
        })
        .catch(error => {
          reject({ error: 'Erro ao excluir atividade do aluno', details: error });
        });
    });
  }

}

module.exports = new UserActivitiesModel();