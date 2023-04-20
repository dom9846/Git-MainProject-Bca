var submittedWork = require("../../model/subject/submittedworks");
const {ObjectId}=require('mongodb');
exports.submitwork = (req, res) => {
    console.log(req.body)
    submittedWork.findOne({ id: req.body.id,studentid: req.body.studentid }, (err, subwork) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (subwork) {
            return res.status(401).json({ 'msg': 'This Subject Is Allready Added' });
        }
        else{
            let newsubject = submittedWork(req.body);
            newsubject.save((err, sub) => {
                if (err) {
                    console.log("err")
                    return res.status(400).json({ 'msg': err });
                }
                return res.status(201).json(sub);
            });
        }
    });
};
exports.submittedworkretrieve = (req, res) => {
    console.log(req.body)
    submittedWork.find({ id:req.body.id }, (err, work) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (work) {
            return res.status(201).json(work);
        }
        return res.status(404).json({ 'msg': 'Something Went Wrong' });
    });
};