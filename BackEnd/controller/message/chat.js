var chat = require('../../model/message/chat');
// const {ObjectId}=require('mongodb');

exports.sendmessage = (req,res) => {

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
exports.getmessage = (req,res) => {
    console.log(req.body)
    chat.find({ id: req.body.id }, (err, msg) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (msg) {
            return res.status(201).json(msg);
        }
    });
}