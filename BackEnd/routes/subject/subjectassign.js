var express = require('express'),
routes = express.Router();
var subjectAssignControl = require('../../controller/subject/subjectassign');
routes.post('/subjectassign', subjectAssignControl.subassign);
module.exports = routes;