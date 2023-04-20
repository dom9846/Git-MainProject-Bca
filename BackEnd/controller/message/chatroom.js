var chatRoom = require('../../model/message/chatroom');
// const {ObjectId}=require('mongodb');

exports.addnewchat = (req, res) => {
    console.log(req.body)
    chatRoom.findOne({ year: req.body.year }, (err, room) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (room) {
            return res.status(401).json({ 'msg': 'Room Allready Added' });
        }
            let newroom = chatRoom(req.body);
            newroom.save((err, nr) => {
                if (err) {
                    return res.status(400).json({ 'msg': err });
                }
                return res.status(201).json(nr);
            });
    });
};

exports.getallchatroom = (req, res) => {
    chatRoom.find({}, (err, rooms) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (rooms) {
            return res.status(201).json(rooms);
        }
    });
};

exports.getstudchatroom = (req, res) => {
    chatRoom.find({ year:req.body.year }, (err, rooms) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (rooms) {
            return res.status(201).json(rooms);
        }
    });
};