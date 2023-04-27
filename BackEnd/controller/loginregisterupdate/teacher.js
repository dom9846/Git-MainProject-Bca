var User = require('../../model/loginregisterupdate/register');
var Teacher=require('../../model/loginregisterupdate/teacher');
var Chat=require('../../model/message/chat');
var Post=require('../../model/newpost/newpost');
var Assignrate=require('../../model/rating/assignrateteacher');
var Subjectassign=require('../../model/subject/subjectassign');
var Subwork=require('../../model/subject/subjectwork');
var RateStudent=require('../../model/rating/ratestudent');
const {ObjectId}=require('mongodb');
// const studreg = require('../../model/loginregisterupdate/studreg');
exports.teacherregister = (req, res) => {
    console.log(req.body)

    User.findOne({ identity: req.body.identity }, (err, user) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (user) {
            User.findOne({ username: req.body.username }, (e,u) =>{
                if(e){
                    return res.status(401).json({ 'msg': e });
                }
                if(u){
                    return res.status(404).json({ 'msg': 'This username is allready taken!'});
                }
                else{
                    User.updateOne( 
                        { _id: ObjectId(user._id) }, 
                        {
                          $set: 
                            {
                                username:req.body.username,
                                password:req.body.password
                            }
                        },(err,u)=>{
                            if(err){
                
                            }
                            if(u){
                                req.body.id = ObjectId(user._id);
                                req.body.fname=user.firstname;
                                req.body.sname=user.secondname;
                                let newTeacherupdate = Teacher(req.body);
                                newTeacherupdate.save((err, ns) => {
                                    if (err) {
                                        return res.status(400).json({ 'msg': "error occured" });
                                    }
                                    if(ns){
                                        return res.status(201).json({ 'msg': "Successfully Registerd" });
                                    }
                                })
                            }
                        } 
                    )
                }
            }
            )
        }
    });
    
};
exports.teacherupdateunamepass = (req, res) => {
    console.log(req.body)

    User.findOne({ _id: req.body.identity }, (err, user) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (user) {
            User.updateOne( 
                { _id: ObjectId(user._id) }, 
                {
                  $set: 
                    {
                        username:req.body.username,
                        password:req.body.password
                    }
                },(err,u)=>{
                    if(err){
                        return res.status(401).json({ 'msg': err });
                    }
                    if(u){
                        return res.status(201).json({ 'msg': "Successfully Updated" });
                    }
                } 
            )
        }
    });
    
};
exports.teacherupdate = (req, res) => {
    console.log(req.body)

    Teacher.findOne({ id: req.body.id }, (err, user) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (user) {
            Teacher.updateOne( 
                { _id: ObjectId(user._id) }, 
                {
                  $set: 
                    {
                        propic:req.body.propic,
                        email:req.body.email,
                        age:req.body.age,
                        mobile:req.body.mobile,
                        qualification:req.body.qualification,
                    }
                },(err,u)=>{
                    if(err){
                        return res.status(400).json({ 'msg': "Error occured"});
                    }
                    if(u){
                        return res.status(201).json({ 'msg': "Profile Updated"});
                    }
                } 
            )
        }
    });
};

exports.getteacher = (req, res) => {
    console.log(req.body)
    Teacher.findOne({ id: req.body.id}, (err, user) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (user) {
            return res.status(201).json(user);
        }
        return res.status(404).json({ 'msg': 'Error occured' });
    });
};
exports.deletelecture=(req,res)=>{
    console.log(req.body)
    User.deleteOne({ _id:req.body._id }, (err, del)=>{
        if(err){
            return res.status(404).json({error:"error"})
        }
        else if(del){
            Teacher.deleteOne({ id:req.body._id }, (err, del2)=>{
                if(err){
                    return res.status(404).json({error:"error"})
                }
                // else if(del2){
                //     return res.status(201).json(del2)
                // }
                // else{
                //     return res.status(404).json({error:t})
                // }
            })
            Chat.deleteMany({ sender:req.body._id }, (err, del2)=>{
                if(err){
                    return res.status(404).json({error:"error"})
                }
                // else if(del2){
                //     return res.status(201).json(del2)
                // }
                // else{
                //     return res.status(404).json({error:t})
                // }
            })
            Post.deleteMany({ userid:req.body._id }, (err, del2)=>{
                if(err){
                    return res.status(404).json({error:"error"})
                }
                // else if(del2){
                //     return res.status(201).json(del2)
                // }
                // else{
                //     return res.status(404).json({error:t})
                // }
            })
            Assignrate.deleteMany({ teacherid:req.body._id }, (err, del2)=>{
                if(err){
                    return res.status(404).json({error:"error"})
                }
                // else if(del2){
                //     return res.status(201).json(del2)
                // }
                // else{
                //     return res.status(404).json({error:t})
                // }
            })
            RateStudent.deleteMany({ teacherid:req.body._id }, (err, del2)=>{
                if(err){
                    return res.status(404).json({error:"error"})
                }
                // else if(del2){
                //     return res.status(201).json(del2)
                // }
                // else{
                //     return res.status(404).json({error:t})
                // }
            })
            Subjectassign.deleteMany({ subteacher:req.body._id }, (err, del2)=>{
                if(err){
                    return res.status(404).json({error:"error"})
                }
                // else if(del2){
                //     return res.status(201).json(del2)
                // }
                // else{
                //     return res.status(404).json({error:t})
                // }
            })
            Subwork.deleteMany({ teacherid:req.body._id }, (err, del2)=>{
                if(err){
                    return res.status(404).json({error:"error"})
                }
                // else if(del2){
                //     return res.status(201).json(del2)
                // }
                // else{
                //     return res.status(404).json({error:t})
                // }
            })
            return res.status(201).json(del)
        }
        else{
            return res.status(404).json({error:t})
        }
    })
}