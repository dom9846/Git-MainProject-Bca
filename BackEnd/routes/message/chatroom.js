var express = require('express'),
routes = express.Router();

var chatRoomControl = require('../../controller/message/chatroom');
routes.post('/addchatroom', chatRoomControl.addchatroom);
module.exports = routes;