var express = require('express'),
routes = express.Router();

var chatRoomControl = require('../../controller/message/chatroom');
routes.post('/addchatroom', chatRoomControl.addnewchat);
routes.post('/getallchatroom', chatRoomControl.getallchatroom);
routes.post('/getstudchatroom', chatRoomControl.getstudchatroom);
module.exports = routes;