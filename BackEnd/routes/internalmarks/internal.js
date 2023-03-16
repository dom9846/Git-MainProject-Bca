var express = require('express'),
routes = express.Router();
var markController = require('../../controller/internalmarks/internal');
routes.post('/internalmark', markController.internalMark);
module.exports = routes;