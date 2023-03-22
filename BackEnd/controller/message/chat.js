var chat = require('../../model/message/chat');
// const {ObjectId}=require('mongodb');

exports.addchat = (req,res) => {

    let newchat = chat(req.body);
    newchat.save((err,nc) => {
        if(err){
            return res.status(400).json({ 'msg':err})
        }
        if(nc){
            return res.status(201).json(nc);
        }
    })
}