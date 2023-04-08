var subjectAssign = require('../../model/subject/subjectassign');
var subjects = require('../../model/subject/subject');
const {ObjectId}=require('mongodb');
exports.subassign = (req, res) => {
    console.log("inn")
    console.log(req.body)

    subjectAssign.findOne({ subid: req.body.subid }, (err, sub) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (sub) {
            subjectAssign.updateOne( 
                { _id: ObjectId(sub._id) }, 
                {
                  $set: 
                    {
                        subteacher:req.body.subteacher
                    }
                },(err,u)=>{
                    if(err){
        
                    }
                    if(u){
                        return res.status(201).json({ 'msg': "Subject Assigned" });
                    }
                } 
            )
        }
    });
};

exports.subretrieve = (req, res) => {
    console.log(req.body)
    subjects.find({ semester: req.body.semester }, (err, sub) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (sub) {
            return res.status(201).json(sub);
        }
    });
};