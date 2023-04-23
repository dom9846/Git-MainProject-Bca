var express = require('express'),
routes = express.Router();
var subjectAssignControl = require('../../controller/subject/subjectassign');
var lecturerecieveControl = require('../../controller/loginregisterupdate/register');
routes.post('/subjectassign', subjectAssignControl.subassign);
routes.post('/subassretrieve', subjectAssignControl.subretrieve);
routes.post('/lectureretrieve', lecturerecieveControl.getlectures);
routes.post('/retrieveassignedsubjects', subjectAssignControl.retrieveassignedsubjects);
module.exports = routes;