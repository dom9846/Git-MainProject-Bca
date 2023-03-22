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