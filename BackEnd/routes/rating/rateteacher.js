var express = require('express'),
routes = express.Router();
var rateteacherControl = require('../../controller/rating/rateteacher');
routes.post('/rateteacher', rateteacherControl.rateteacher);
routes.post('/markrate', rateteacherControl.markrating);
module.exports = routes;