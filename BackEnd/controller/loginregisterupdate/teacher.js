var User = require('../../model/loginregisterupdate/register');
var Teacher=require('../../model/loginregisterupdate/teacher');
const {ObjectId}=require('mongodb');
// const studreg = require('../../model/loginregisterupdate/studreg');
exports.teacherregister = (req, res) => {
    console.log(req.body)

    User.findOne({ identity: req.body.identity }, (err, user) => {
        if (err) {
            // console.log("err")
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
                },(err,user)=>{
                    if(err){
                        return res.status(404).json({ 'msg': err });
                    }
                    if(user){
                        req.body.id = ObjectId(user._id);
                        let newTeachUpdate = Teacher(req.body);
                        newTeachUpdate.save((err, ns) => {
                            if (err) {
                                return res.status(400).json({ 'msg': "error occured" });
                            }
                            if(ns){
                                return res.status(201).json({ 'msg': "Successfully Registered" });
                            }
                        })
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