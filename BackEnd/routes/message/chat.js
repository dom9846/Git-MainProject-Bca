var express = require('express'),
routes = express.Router();

var chatControl = require('../../controller/message/chat');
routes.post('/sendmessage', chatControl.sendmessage);
routes.post('/getmessage', chatControl.getmessage);
module.exports = routes;