const user_activitiesRoute = require('./user_activitiesRoute');
const userRoute = require('./userRoute');
const activitiesRoute = require('./activitiesRoute');


module.exports = (app, express) => {
  app.use(express.json());
  app.use(express.urlencoded({ extended: true }));
  app.use(user_activitiesRoute);
  app.use(userRoute);
  app.use(activitiesRoute);
}