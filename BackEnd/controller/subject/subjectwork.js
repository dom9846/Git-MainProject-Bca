var subjectWork = require('../../model/subject/subjectwork');
var submittedWork = require('../../model/subject/submittedworks');
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
exports.showsubdetailssemways = (req, res) => {
    console.log(req.body)
    subjectWork.find({semester: req.body.semester}, (err, subwork) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (subwork) {
            return res.status(201).json(subwork);
        }
        return res.status(404).json({ 'msg': 'Something Went Wrong' });
    });
};

exports.removesubjectwork=(req,res)=>{
    console.log(req.body)
    subjectWork.deleteOne({ _id:req.body._id }, (err, del)=>{
        if(err){
            return res.status(404).json({error:"error"})
        }
        else if(del){
            submittedWork.deleteMany({ id:req.body._id }, (err, delchat)=>{
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