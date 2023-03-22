var express = require('express'),
routes = express.Router();
var attendanceController = require('../../controller/attendance/attendance');
routes.post('/attendancemark', attendanceController.attendanceMark);
module.exports = routes;