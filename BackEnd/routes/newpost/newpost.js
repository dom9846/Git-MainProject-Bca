var express = require('express'),
routes = express.Router();

var newpostControl = require('../../controller/newpost/newpost');
routes.post('/newpost', newpostControl.addpost);
module.exports = routes;