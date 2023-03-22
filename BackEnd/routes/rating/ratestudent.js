var express = require('express'),
routes = express.Router();
var ratestudentControl = require('../../controller/rating/ratestudent');
routes.post('/ratestudent', ratestudentControl.ratestudent);
module.exports = routes;