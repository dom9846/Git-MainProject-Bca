var chatroom = require("../../model/chats/chatroom");
exports.addchatroom = (req, res) => {
    console.log(req.body)
    chatroom.findOne({ year: req.body.year}, (err, room) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (room) {
            return res.status(401).json({ 'msg': 'Chat Room Allready Created' });
        }
      
            let newRoom = chatroom(req.body);
            newRoom.save((err, newroom) => {
                if (err) {
                    return res.status(400).json({ 'msg': err });
                }
                return res.status(201).json(newroom);
            });

    });
};