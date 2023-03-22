var express = require('express'),
routes = express.Router();

var chatControl = require('../../controller/message/chat');
routes.post('/addchat', chatControl.addchat);
module.exports = routes;