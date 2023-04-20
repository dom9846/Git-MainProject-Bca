var express = require('express'),
routes = express.Router();
var subjectworkControl = require('../../controller/subject/subjectwork');
var submitworkControl = require('../../controller/subject/submittedworks');
routes.post('/assignsubjectwork', subjectworkControl.subworkassign);
routes.post('/retrievesubjectwork', subjectworkControl.subworksretrieve);
routes.post('/retrievesubjectworksemways', subjectworkControl.showsubdetailssemways);
routes.post('/submitsubjectwork', submitworkControl.submitwork);
routes.post('/retrievesubmittedwork', submitworkControl.submittedworkretrieve);
module.exports = routes;