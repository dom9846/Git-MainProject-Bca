var express = require('express'),
routes = express.Router();
var attendanceController = require('../../controller/attendance/attendance');
routes.post('/attendancemark', attendanceController.attendanceMark);
routes.post('/getstudattendances', attendanceController.getstudattendances);
routes.post('/getallattendances', attendanceController.getsemattendances);
module.exports = routes;