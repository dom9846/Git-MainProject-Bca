var express = require('express'),
routes = express.Router();
var subjectworkControl = require('../../controller/subject/subjectwork');
routes.post('/subjectwork', subjectworkControl.subworkassign);
module.exports = routes;