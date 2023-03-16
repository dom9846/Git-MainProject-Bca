var express = require('express'),
routes = express.Router();
var userController = require('../../controller/loginregisterupdate/register');
routes.post('/login', userController.loginUser);
module.exports = routes;