var express = require('express'),
routes = express.Router();
var rateteacherControl = require('../../controller/rating/rateteacher');
routes.post('/assignrateteacher', rateteacherControl.assignrateteacher);
routes.post('/rateteacher', rateteacherControl.rateTeacher);
routes.post('/retrieveratetask', rateteacherControl.ratetaskretrieve);
routes.post('/retrieveratetaskbyyear', rateteacherControl.ratetaskretrievebyyear);
routes.post('/retrieveratings', rateteacherControl.retrieverates);
routes.post('/deleteratetask', rateteacherControl.deleteratetask);
module.exports = routes;