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

  updateUserActivities(newUserActivities, id) {
    const sql = 'UPDATE user_activities SET ? WHERE id = ?';
    return this.executeQuery(sql, [newUserActivities, id]);
  }

  deleteUserActivities(userAndActivityID) {
    const sql = 'DELETE FROM user_activities WHERE user_id = ? AND activity_id = ?';
    return this.executeQuery(sql, [userAndActivityID.user_id, userAndActivityID.activity_id]);
  }

}

module.exports = new UserActivitiesModel();