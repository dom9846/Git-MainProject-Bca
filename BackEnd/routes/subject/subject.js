var express = require('express'),
routes = express.Router();
var subjectControl = require('../../controller/subject/subject');
routes.post('/subjectadd', subjectControl.subjectadd);
module.exports = routes;