var express = require('express'),
routes = express.Router();
var markController = require('../../controller/internalmarks/internal');
routes.post('/putinternalmark', markController.internalMark);
routes.post('/getinternalmark', markController.getinternals);
module.exports = routes;