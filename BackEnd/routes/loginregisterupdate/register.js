var express = require('express'),
routes = express.Router();
var userController = require('../../controller/loginregisterupdate/register');
routes.post('/register', userController.registerUser);
module.exports = routes;