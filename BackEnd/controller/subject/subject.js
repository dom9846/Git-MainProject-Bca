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
exports.showsubdetails = (req, res) => {
    console.log(req.body)
    var semester = req.body.semester;
    // var semester1=parseInt(semester);
    // console.log(semester1);
    Subject.aggregate([
        {
            $lookup: {
              from: "subjectassigns",
              localField: "_id",
              foreignField: "subid",
              as: "sub_details"
            }
        },
        {
            $match:{
                // "user_type":"Student",
                "semester":semester,
                // "sub_details.subteacherfname":{"$exists":true}
            }
        }
    ]).exec(
        function(err,data){
            if(err){throw err}
            if(data){
                console.log(data);
                return res.status(201).json(data);
            }
        }
    )
};
exports.subjectretrieve = (req, res) => {
    console.log(req.body)
    Subject.findOne({ _id: req.body._id }, (err, user) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (user) {
            return res.status(201).json({token,user});
        }
        // return res.status(404).json({ 'msg': 'Invalid username and Password' });
    });
};
exports.removesubject=(req,res)=>{
    console.log(req.body)
    Subject.deleteOne({ _id:req.body._id }, (err, del)=>{
        if(err){
            return res.status(404).json({error:"error"})
        }
        else if(del){
            subjectAssign.deleteOne({ subid:req.body._id }, (err, delchat)=>{
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