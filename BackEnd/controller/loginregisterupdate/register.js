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
            return res.status(404).json({ 'msg': 'The user already exists' });
        }
        let newUser = User(req.body);
        newUser.save((err, user) => {
            if (err) {
                return res.status(402).json({ 'msg': err });
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

exports.regCheck = (req, res) => {
    // console.log(req.body)
    User.findOne({ identity: req.body.identity }, (err, user) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        else if (user) {
                if(user.username == undefined){
                    return res.status(201).json(user);
                }
                else{
                    return res.status(404).json({ 'msg': 'allready registered' });
                }
        }
        else{
            return res.status(401).json({ 'msg': 'User not exists' });
        }
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
        return res.status(404).json({ 'msg': 'Invalid username and Password' });
    });
};

// exports.getlectures = (req, res) => {
//     console.log(req.body)
//     User.find({ user_type: req.body.user_type}, (err, user) => {
//         if (err) {
//             return res.status(400).json({ 'msg': err });
//         }
//         if (user) {
//             return res.status(201).json(user);
//         }
//         return res.status(404).json({ 'msg': 'Invalid username and Password' });
//     });
// };
exports.getlectures = (req, res) => {
    // console.log(req.body)
    // User.find({ user_type: req.body.user_type}, (err, user) => {
    //     if (err) {
    //         return res.status(400).json({ 'msg': err });
    //     }
    //     if (user) {
            User.aggregate([
                {
                    $lookup: {
                      from: "teachers",
                      localField: "_id",
                      foreignField: "id",
                      as: "lec_details"
                    }
                },
                {
                    $match:{
                        "user_type":"Teacher"
                    }
                }
            ]).exec(
                function(err,data){
                    if(err){throw err}
                    if(data){
                        return res.status(201).json(data);
                    }
                }
            )
    //     }
    // });
};

exports.getstudents = (req, res) => {
    console.log(req.body)
    var year1 = req.body.year;
    var year2=parseInt(year1);
    // User.find({ user_type: req.body.user_type}, (err, user) => {
    //     if (err) {
    //         return res.status(400).json({ 'msg': err });
    //     }
    //     if (user) {
            User.aggregate([
                {
                    $lookup: {
                      from: "students",
                      localField: "_id",
                      foreignField: "id",
                      as: "stud_details"
                    }
                },
                {
                    $match:{
                        "user_type":"Student",
                        "stud_details.year":year2
                    }
                }
            ]).exec(
                function(err,data){
                    if(err){throw err}
                    if(data){
                        return res.status(201).json(data);
                    }
                }
            )
    //     }
    // });
};