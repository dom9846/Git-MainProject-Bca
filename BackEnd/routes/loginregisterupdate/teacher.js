var express = require('express'),
routes = express.Router();
var teacherControl = require('../../controller/loginregisterupdate/teacher');
routes.post('/teacherregister', teacherControl.teacherregister);
routes.post('/teacherupdateunamepass', teacherControl.teacherupdateunamepass);
routes.post('/teacherupdate', teacherControl.teacherupdate);
module.exports = routes;