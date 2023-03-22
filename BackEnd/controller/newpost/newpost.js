var newPost = require('../../model/newpost/newpost');
const {ObjectId}=require('mongodb');
exports.addpost = (req, res) => {
    let newpost = newPost(req.body);
    newpost.save((err, post) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if(post){
            return res.status(201).json(post);
        }
    });
};