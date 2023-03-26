var express = require('express'),
routes = express.Router();
var rateteacherControl = require('../../controller/rating/rateteacher');
routes.post('/assignrateteacher', rateteacherControl.assignrateteacher);
routes.post('/rateteacher', rateteacherControl.rateTeacher);
module.exports = routes;