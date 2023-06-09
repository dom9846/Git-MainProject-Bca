var rateStudent = require('../../model/rating/ratestudent');
const {ObjectId}=require('mongodb');
exports.ratestudent = (req, res) => {
    rateStudent.findOne({ teacherid: req.body.teacherid,studentid: req.body.studentid,subjectid: req.body.subjectid}, (err, rate) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (rate) {
            rateStudent.updateOne( 
                { _id: ObjectId(rate._id) }, 
                {
                  $set: 
                    {
                        rating:req.body.rating
                    }
                },(err,u)=>{
                    if(err){
                        return res.status(401).json({ 'msg': err });
                    }
                    if(u){
                        return res.status(201).json({ 'msg': "Successfully updated" });
                    }
                } 
            )
        }
        else{
            let newstudentrate = rateStudent(req.body);
            newstudentrate.save((err, rate) => {
                if (err) {
                    return res.status(400).json({ 'msg': err });
                }
                if(rate){
                    return res.status(201).json(rate);
                }
            });
        }     
    });

};
exports.retrieveratesofstud = (req, res) => {
    console.log(req.body)
    rateStudent.find({ semester: req.body.semester,studentid:req.body.studentid }, (err, rate) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (rate) {
            return res.status(201).json(rate);
        }
    });
};