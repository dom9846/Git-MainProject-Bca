var chatRoom = require('../../model/message/chatroom');
// const {ObjectId}=require('mongodb');

exports.addchatroom = (req,res) => {

    let newchatroom = chatRoom(req.body);
    newchatroom.save((err,ncr) => {
        if(err){
            return res.status(400).json({ 'msg':err})
        }
        if(ncr){
            return res.status(201).json({ 'msg': "Successfully created" });
        }
    })
}