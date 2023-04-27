var express = require('express'),
routes = express.Router();

var newpostControl = require('../../controller/newpost/newpost');
routes.post('/addnewpost', newpostControl.addpost);
routes.post('/getposts', newpostControl.retrieveposts);
routes.post('/retrieveposts', newpostControl.retrieveallposts);
routes.post('/deleteposts', newpostControl.deletepost);
module.exports = routes;