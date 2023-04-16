var express = require('express'),
routes = express.Router();
var timetableControl = require('../../controller/timetable/timetable');
routes.post('/timetableupdate', timetableControl.timetableupdate);
routes.post('/timetableadd', timetableControl.timetableadd);
routes.post('/gettimetables', timetableControl.timetableretrieve);
module.exports = routes;