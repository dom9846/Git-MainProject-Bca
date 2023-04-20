var express = require('express'),
routes = express.Router();
var subjectControl = require('../../controller/subject/subject');
routes.post('/subjectadd', subjectControl.subjectadd);
routes.post('/showsubjectdetails', subjectControl.showsubdetails);
routes.post('/subjectretrieve', subjectControl.subjectretrieve);
module.exports = routes;