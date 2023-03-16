var User = require('../../model/loginregisterupdate/register');
var Student=require('../../model/loginregisterupdate/student');
const {ObjectId}=require('mongodb');
exports.studentregister = (req, res) => {
    // console.log(req.body)

    User.findOne({ identity: req.body.identity }, (err, user) => {
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
        
                    }
                    if(u){
                        req.body.id = ObjectId(user._id);
                        let newStudentupdate = Student(req.body);
                        newStudentupdate.save((err, ns) => {
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
    });
};
exports.studentupdate = (req, res) => {
    console.log(req.body)

    Student.findOne({ id: req.body.id }, (err, user) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (user) {
            Student.updateOne( 
                { _id: ObjectId(user._id) }, 
                {
                  $set: 
                    {
                        propic:req.body.propic,
                        age:req.body.age,
                        email:req.body.email,
                        mobile:req.body.mobile,
                        parent:req.body.parent,
                        parentcontact:req.body.parentcontact,
                        year:req.body.year,
                        semester:req.body.semester,

                    }
                },(err,u)=>{
                    if(err){
                        return res.status(404).json({ 'msg': err });
                    }
                    if(u){
                        return res.status(201).json({ 'msg': "Profile Updated" });
                    }
                } 
            )
        }
    });
};