var User = require('../../model/loginregisterupdate/register');
var Admin = require('../../model/loginregisterupdate/admin');
const {ObjectId}=require('mongodb');
exports.adminregister = (req, res) => {
    console.log(req.body)

    User.findOne({ identity: req.body.identity }, (err, user) => {
        if (err) {
            // console.log("err")
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
                                let newAdminupdate = Admin(req.body);
                                newAdminupdate.save((err, ns) => {
                                    if (err) {
                                        return res.status(402).json({ 'msg': "error occured" });
                                    }
                                    if(ns){
                                        return res.status(201).json({ 'msg': "Successfully Registerd" });
                                    }
                                })
                            }
                        } 
                    )
                }
            })
        }
    });
};
exports.adminupdate = (req, res) => {
    console.log(req.body)

    Admin.findOne({ id: req.body.id }, (err, user) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (user) {
            Admin.updateOne( 
                { _id: ObjectId(user._id) }, 
                {
                  $set: 
                    {
                        propic:req.body.propic,
                        email:req.body.email,
                        mobile:req.body.mobile,
                        age:req.body.age,
                        qualification:req.body.qualification
                    }
                },(err,u)=>{
                    if(err){
        
                    }
                    if(u){
                        return res.status(201).json({ 'msg': "Profile Updated" });
        
                    }
                } 
            )
        }
    });
};