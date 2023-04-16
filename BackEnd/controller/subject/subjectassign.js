var subjectAssign = require('../../model/subject/subjectassign');
var subjects = require('../../model/subject/subject');
const {ObjectId}=require('mongodb');
const mongoose = require('mongoose');
exports.subassign = (req, res) => {
    subjectAssign.findOne({ subid: req.body.subid },(err,subassign)=>{
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (subassign) {
            // console.log("err")
            return res.status(401).json({ 'msg': err });
        }
            let newsubjectass = subjectAssign(req.body);
            newsubjectass.save((err, subjectass) => {
                if (err) {
                    console.log("err")
                    return res.status(400).json({ 'msg': err });
                }
                // req.body.subid = ObjectId(subject._id);
                // let newSubjadd = subjectAssign(req.body)
                // newSubjadd.save((err, ns) => {
                //     if (err) {
                //         return res.status(400).json({ 'msg': "error occured" });
                //     }
                // })
                return res.status(201).json(subjectass);
            })
    })
};

// exports.subretrieve = (req, res) => {
//     console.log(req.body.semester)
//     subjects.find({ semester: req.body.semester }, (err, sub) => {
//         if (err) {
//             // console.log("err")
//             return res.status(400).json({ 'msg': err });
//         }
//         if (sub) {
//             console.log("hello")
//             return res.status(201).json(sub);
//         }
        
//         return res.status(400).json(err);
//     });
// };
exports.subretrieve = (req, res) => {
    console.log(req.body)
    subjects.find({ semester: req.body.semester}, (err, subj) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (subj) {
            return res.status(201).json(subj);
        }
        return res.status(404).json({ 'msg': 'Invalid username and Password' });
    });
};
exports.retrieveassignedsubjects = (req, res) => {
    console.log(req.body)
    const teacherid = mongoose.Types.ObjectId(req.body.subteacher);
    console.log(teacherid);
    subjects.aggregate([
        {
            $lookup: {
              from: "subjectassigns",
              localField: "_id",
              foreignField: "subid",
              as: "sub_details"
            }
        },
        {
            $match:{
                // "user_type":"Student",
                "sub_details.subteacher":teacherid,
                "sub_details.subteacherfname":{"$exists":true}
            }
        }
    ]).exec(
        function(err,data){
            if(err){throw err}
            if(data){
                console.log(data);
                return res.status(201).json(data);
            }
        }
    )
};