var attendance = require("../../model/attendance/attendance");
exports.attendanceMark = (req, res) => {
    console.log(req.body)
    attendance.findOne({ semester:req.body.semester,date: req.body.date,period:req.body.period}, (err, mark) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (mark) {
            return res.status(400).json({ 'msg': 'Allready Entered' });
        }
        let newAttendance = attendance(req.body);
        newAttendance.save((err, mark) => {
            if (err) {
                console.log("err")
                return res.status(400).json({ 'msg': err });
            }
            return res.status(201).json(mark);
        });

    });
};