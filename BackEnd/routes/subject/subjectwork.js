var express = require('express'),
routes = express.Router();
var subjectworkControl = require('../../controller/subject/subjectwork');
routes.post('/assignsubjectwork', subjectworkControl.subworkassign);
routes.post('/retrievesubjectwork', subjectworkControl.subworksretrieve);
module.exports = routes;