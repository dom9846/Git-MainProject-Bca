var assignrateTeacher = require('../../model/rating/assignrateteacher');
var rateteacher = require('../../model/rating/rateteacher');
const {ObjectId}=require('mongodb');
exports.assignrateteacher = (req, res) => {
    assignrateTeacher.findOne({ teacherid: req.body.teacherid, year: req.body.year }, (err, user) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (user) {
            return res.status(401).json({ 'msg': 'Allready Assigned,Remove It First!' });
        }
        let newteacherateassign = assignrateTeacher(req.body);
        newteacherateassign.save((err, assign) => {
            if (err) {
                return res.status(400).json({ 'msg': err });
            }
            if(assign){
                req.body.id = ObjectId(assign._id)
                let newteachrate = rateteacher(req.body);
                newteachrate.save((err,rate) =>{
                    if(err){
                        return res.status(402).json({ 'msg': err });
                    }
                    if(rate){
                        return res.status(201).json({ 'msg': 'Successfully Assigned!' });
                    }
                });
            }
        });
    })

};
exports.rateTeacher = (req, res) => {
    rateteacher.findOne({ id: req.body.id }, (err, user) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (user) {
            rateteacher.findOne({ id: req.body.id, studentid: req.body.studentid}, (err, u) => {
                if(err){
                    return res.status(401).json({ 'msg': 'error occured'});
                }
                if(u){
                    return res.status(402).json({ 'msg': 'you have allready rated!'});
                }else{
                    rateteacher.updateOne( 
                        { _id: ObjectId(user._id) }, 
                        {
                            $set: 
                            {
                                studentid:req.body.studentid,
                                rating1:req.body.rating1,
                                rating2:req.body.rating2,
                                rating3:req.body.rating3,
                                overall:req.body.overall,
                                date:req.body.date,
                            }
                        },(err,u)=>{
                            if(err){
                                return res.status(400).json({ 'msg': "Error occured"});
                            }
                            if(u){
                                return res.status(201).json({ 'msg': "Successfully Rated"});
                            }
                        } 
                    )
                }
            })
        }
    });  
};