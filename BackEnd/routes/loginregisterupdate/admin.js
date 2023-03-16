var express = require('express'),
routes = express.Router();

var adminControl = require('../../controller/loginregisterupdate/admin');
routes.post('/adminregister', adminControl.adminregister);
routes.post('/adminupdate', adminControl.adminupdate);

module.exports = routes;