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
exports.retrieveposts = (req, res) => {
    console.log(req.body)
    newPost.find({}, (err, post) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (post) {
            return res.status(201).json(post);
        }
    });
};
exports.retrieveallposts = (req, res) => {
    console.log(req.body);
    newPost.find({})
        .sort({ datetime: -1 }) // sort by datetime in descending order
        .exec((err, posts) => {
            if (err) {
                return res.status(400).json({ 'msg': err });
            }
            if (posts) {
                const formattedPosts = posts.map((post) => ({
                    post: post.post,
                    comment: post.comment,
                    userid: post.userid,
                    userpic: post.userpic,
                    userfname: post.userfname,
                    usersname: post.usersname,
                    datetime: post.datetime,
                }));
                return res.status(201).json(formattedPosts);
            }
        });
};
exports.deletepost=(req,res)=>{
    console.log(req.body)
    newPost.deleteOne({ _id:req.body._id }, (err, del)=>{
        if(err){
            return res.status(404).json({error:"error"})
        }
        else if(del){
            return res.status(201).json(del)
        }
        else{
            return res.status(404).json({error:t})
       }
    })
}