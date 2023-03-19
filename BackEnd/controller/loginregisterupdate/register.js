var User = require('../../model/loginregisterupdate/register');
var jwt = require("jsonwebtoken");
const expressJwt = require('express-jwt');

exports.registerUser = (req, res) => {
    console.log(req.body)
    User.findOne({ identity: req.body.identity }, (err, user) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (user) {
            return res.status(400).json({ 'msg': 'The user already exists' });
        }
        let newUser = User(req.body);
        newUser.save((err, user) => {
            if (err) {
                return res.status(400).json({ 'msg': err });
            }
            else if(user){
                if (req.body.user_type == "Student") {
                    return res.status(201).json({'msg': "Student Successfully Added"});
                }
                if(req.body.user_type == "Teacher"){
                    return res.status(201).json({'msg': "Teacher Successfully Added"});
                }
                if(req.body.user_type == "Admin"){
                    return res.status(201).json({'msg': "Admin Successfully Added"});
                }
            }           
            //return res.status(201).json(user);
        });

    });
};

exports.LoginCheck = (req, res) => {
    console.log(req.body)
    User.findOne({ identity: req.body.identity }, (err, user) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (user) {
            return res.status(201).json(user);
        }
        return res.status(400).json({ 'msg': 'User not exists' });
    });
};

exports.loginUser = (req, res) => {
    console.log(req.body)
    User.findOne({ username: req.body.username, password: req.body.password }, (err, user) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (user) {
            // return res.status(201).json(user);
            const token = jwt.sign({ _id:user._id }, process.env.SECRET);
            //put token in cookie
            res.cookie("token",token, { expire: new Date() + 9999 } );
            return res.status(201).json({token,user});
        }
        return res.status(400).json({ 'msg': 'User not exists' });
    });
};