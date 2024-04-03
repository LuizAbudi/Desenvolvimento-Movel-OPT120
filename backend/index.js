const express = require('express');
const app = express();
const port = 3000;
const router = require('./src/routes/index');
const connection = require('./src/database/connection');
const tables = require('./src/database/tables');

router(app, express);
tables.init(connection);

app.listen(port, (error) => {
  if (error) {
    console.log('Deu erro');
    return;
  }
  console.log('Servidor rodando na porta 3000');
});