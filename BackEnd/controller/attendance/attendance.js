var attendance = require("../../model/attendance/attendance");
exports.attendanceMark = (req, res) => {
    console.log(req.body)
    attendance.findOne({ semester:req.body.semester,date: req.body.date,period:req.body.period}, (err, mark) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (mark) {
            return res.status(401).json({ 'msg': 'Allready Entered' });
        }else{
            let newAttendance = attendance(req.body);
            newAttendance.save((err, attend) => {
                if (err) {
                    console.log("err")
                    return res.status(402).json({ 'msg': err });
                }
                return res.status(201).json(attend);
            });
        }
    });
};
exports.getsemattendances = (req, res) => {
    console.log(req.body)
    attendance.find({ semester:req.body.semester}, (err, allattend) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (allattend) {
            // console.log(allattend);
            return res.status(201).json(allattend);
        }
    });
};
exports.getstudattendances = (req, res) => {
    // console.log(req.body)
    attendance.find({ semester:req.body.semester, 'absentstudentlist._id': req.body._id}, (err, studattend) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (studattend) {
            return res.status(201).json(studattend);
        }
    });
};

exports.deleteattendance=(req,res)=>{
    console.log(req.body)
    attendance.deleteMany({ semester:req.body.semester }, (err, del)=>{
        if(err){
            return res.status(404).json({error:"error"})
        }
        else if(del){
            return res.status(201).json(del)
        }
        else{
            return res.status(404).json({error:t})
       }
    })
}