var subjectWork = require('../../model/subject/subjectwork');
// const {ObjectId}=require('mongodb');
exports.subworkassign = (req, res) => {

    let newsubjectwork = subjectWork(req.body);
    newsubjectwork.save((err, subwork) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if(subwork){
            return res.status(201).json(subwork);
        }
    });
};
exports.subworksretrieve = (req, res) => {
    console.log(req.body)
    subjectWork.find({ subjectid:req.body.subjectid,semester: req.body.semester,teacherid:req.body.teacherid}, (err, subwork) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (subwork) {
            return res.status(201).json(subwork);
        }
        return res.status(404).json({ 'msg': 'Something Went Wrong' });
    });
};