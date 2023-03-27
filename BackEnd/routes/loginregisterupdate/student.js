var express = require('express'),
routes = express.Router();

var studentControl = require('../../controller/loginregisterupdate/student');
routes.post('/studentregister', studentControl.studentregister);
routes.post('/studentupdateunamepass', studentControl.studentupdateunamepass);
routes.post('/studentupdate', studentControl.studentupdate);

module.exports = routes;