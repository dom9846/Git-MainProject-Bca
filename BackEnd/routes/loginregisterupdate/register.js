var express = require('express'),
routes = express.Router();
var userController = require('../../controller/loginregisterupdate/register');
routes.post('/register', userController.registerUser);
routes.post('/getlectures', userController.getlectures);
routes.post('/getstudents', userController.getstudents);
module.exports = routes;