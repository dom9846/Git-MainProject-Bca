var subjectAssign = require('../../model/subject/subjectassign');
var subjects = require('../../model/subject/subject');
const {ObjectId}=require('mongodb');
exports.subassign = (req, res) => {
    subjectAssign.findOne({ subid: req.body.subid, subteacher: req.body.subteacher },(err,subassign)=>{
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