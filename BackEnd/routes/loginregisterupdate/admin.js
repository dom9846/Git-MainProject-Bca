var express = require('express'),
routes = express.Router();

var adminControl = require('../../controller/loginregisterupdate/admin');
routes.post('/adminregister', adminControl.adminregister);
routes.post('/adminupdateunamepass', adminControl.adminupdateunamepass);
routes.post('/adminupdate', adminControl.adminupdate);
routes.post('/getadmin', adminControl.getadmin);

module.exports = routes;