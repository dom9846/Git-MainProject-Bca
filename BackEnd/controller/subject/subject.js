var Subject = require("../../model/subject/subject");
var subjectAssign = require("../../model/subject/subjectassign");
const {ObjectId}=require('mongodb');
exports.subjectadd = (req, res) => {
    console.log(req.body)
    Subject.findOne({ subjectname: req.body.subjectname }, (err, subject) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (subject) {
            return res.status(400).json({ 'msg': 'This Subject Is Allready Added' });
        }
        let newsubject = Subject(req.body);
        newsubject.save((err, subject) => {
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
            return res.status(201).json(subject);
        });

    });
};