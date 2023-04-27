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
                return res.status(201).json({ 'msg': 'Successfully Assigned!' });
            }
        });
    })

};
exports.rateTeacher = (req, res) => {
    console.log(req);
    rateteacher.findOne({ id: req.body.id,studentid:req.body.studentid }, (err, user) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (user) {
            return res.status(402).json({ 'msg': 'you have allready rated!'});
        }else{
            let newrate = rateteacher(req.body);
            newrate.save((err, rate) => {
                if (err) {
                    return res.status(400).json({ 'msg': err });
                }
                if(rate){
                    return res.status(201).json({ 'msg': 'Successfully rated!' });
                }
            });
        }
    });  
};
exports.ratetaskretrieve = (req, res) => {
    console.log(req.body)
    assignrateTeacher.find({ teacherid: req.body.teacherid}, (err, subj) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (subj) {
            return res.status(201).json(subj);
        }
        // return res.status(404).json({ 'msg': 'Invalid username and Password' });
    });
};
exports.ratetaskretrievebyyear = (req, res) => {
    console.log(req.body)
    assignrateTeacher.find({ year: req.body.year}, (err, task) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (task) {
            return res.status(201).json(task);
        }
    });
};
exports.retrieverates = (req, res) => {
    console.log(req.body)
    rateteacher.find({ id: req.body.id }, (err, rate) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (rate) {
            return res.status(201).json(rate);
        }
    });
};
exports.deleteratetask=(req,res)=>{
    console.log(req.body)
    assignrateTeacher.deleteOne({ _id:req.body._id }, (err, del)=>{
        if(err){
            return res.status(404).json({error:"error"})
        }
        else if(del){
            rateteacher.deleteMany({ id:req.body._id }, (err, delchat)=>{
            if(err){
                return res.status(404).json({error:"error"})
            }
            else if(delchat){
                return res.status(201).json(delchat)
            }
            else{
                return res.status(404).json({error:t})
            }
        })
        }
        else{
            return res.status(404).json({error:t})
        }
    })
}