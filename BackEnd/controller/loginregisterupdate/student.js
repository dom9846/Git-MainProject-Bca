var User = require('../../model/loginregisterupdate/register');
var Student=require('../../model/loginregisterupdate/student');
var Rateteacher=require('../../model/rating/rateteacher');
var Submittedwork=require('../../model/subject/submittedworks');
var Chat=require('../../model/message/chat');
var Post=require('../../model/newpost/newpost');
var Internal=require('../../model/internalmarks/internal');
const {ObjectId}=require('mongodb');
exports.studentregister = (req, res) => {
    // console.log(req.body)

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
            }
            )
        }
    });
};
exports.studentupdateunamepass = (req, res) => {
    // console.log(req.body)

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
                        return res.status(400).json({ 'msg': err });
                    }
                    if(u){
                        return res.status(201).json({'msg':'Succesfully Updated'})
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
                        rollno:req.body.rollno,
                        email:req.body.email,
                        mobile:req.body.mobile,
                        parent:req.body.parent,
                        parentcontact:req.body.parentcontact,
                        year:req.body.year,
                        semester:req.body.semester
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

exports.getstudent = (req, res) => {
    console.log(req.body)
    Student.findOne({ id: req.body.id}, (err, user) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (user) {
            return res.status(201).json(user);
        }
        return res.status(404).json({ 'msg': 'Error occured' });
    });
};
exports.deletestudent=(req,res)=>{
    console.log(req.body)
    User.deleteOne({ _id:req.body._id }, (err, del)=>{
        if(err){
            return res.status(404).json({error:"error"})
        }
        else if(del){
            Student.deleteOne({ id:req.body._id }, (err, del2)=>{
                console.log("1")
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
                console.log("2")
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
                console.log("3")
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
            Rateteacher.deleteMany({ studentid:req.body._id }, (err, del2)=>{
                console.log("4")
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
            Submittedwork.deleteMany({ studentid:req.body._id }, (err, del2)=>{
                console.log("5")
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
            Internal.deleteMany({ studentid:req.body._id }, (err, del2)=>{
                console.log("6")
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