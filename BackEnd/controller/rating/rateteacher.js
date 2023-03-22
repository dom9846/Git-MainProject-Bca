var rateTeacher = require('../../model/rating/rateteacher');
const {ObjectId}=require('mongodb');
exports.rateteacher = (req, res) => {

    let newteacherate = rateTeacher(req.body);
    newteacherate.save((err, rate) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if(rate){
            return res.status(201).json(rate);
        }
    });

};
exports.markrating = (req, res) => {

    // rateTeacher.findOne({ id: req.body.id }, (err, rate) => {
    //     if (err) {
    //         return res.status(400).json({ 'msg': err });
    //     }
    //     if (rate) {
    //         rateTeacher.updateOne( 
    //             { _id: ObjectId(rate._id) }, 
    //             {
    //               $set: 
    //                 {
    //                     rating:[{
    //                         studentid:req.body.studentid,
    //                         rate:req.body.rate
    //                     }]
    //                 }
    //             },(err,u)=>{
    //                 if(err){
        
    //                 }
    //                 if(u){
    //                     return res.status(201).json({ 'msg': "Successfully recorded" });
    //                 }
    //             } 
    //         )
    //     }
    // });
    let newteacheratemark = rateTeacher(req.body);
    newteacheratemark.save((err, rate) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if(rate){
            return res.status(201).json(rate);
        }
    });

};