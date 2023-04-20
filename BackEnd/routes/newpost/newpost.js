var express = require('express'),
routes = express.Router();

var newpostControl = require('../../controller/newpost/newpost');
routes.post('/addnewpost', newpostControl.addpost);
routes.post('/retrieveposts', newpostControl.retrieveallposts);
module.exports = routes;