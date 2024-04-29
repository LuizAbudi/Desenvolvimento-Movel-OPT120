const usersTable = `
    CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    is_adm BOOLEAN NOT NULL
);`

const activitiesTable = `
CREATE TABLE IF NOT EXISTS activities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    due_date TIMESTAMP NOT NULL
);`

const userActivitiesTable = `
CREATE TABLE IF NOT EXISTS user_activities (
    user_id INT,
    activity_id INT,
    delivery_date TIMESTAMP NOT NULL,
    score FLOAT NOT NULL,
    PRIMARY KEY (user_id, activity_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (activity_id) REFERENCES activities(id) ON DELETE CASCADE
);
`

class Tables {
  init(connection) {
    this.connection = connection;
    this.createTable();
  }

  createTable() {
    this.connection.query(usersTable, (error) => {
      if (error) {
        console.log(error);
      } else {
        console.log('Tabelas user criada com sucesso');
      }
    });

    this.connection.query(activitiesTable, (error) => {
      if (error) {
        console.log(error);
      } else {
        console.log('Tabelas activities criada com sucesso');
      }
    });

    this.connection.query(userActivitiesTable, (error) => {
      if (error) {
        console.log(error);
      } else {
        console.log('Tabelas user_activities criada com sucesso');
      }
    });
  }
}

module.exports = new Tables();
