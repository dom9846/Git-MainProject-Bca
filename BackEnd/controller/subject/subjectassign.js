var subjectAssign = require('../../model/subject/subjectassign');
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