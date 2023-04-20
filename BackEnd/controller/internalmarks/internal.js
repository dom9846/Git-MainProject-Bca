var internalmark = require("../../model/internalmarks/internal");
exports.internalMark = (req, res) => {
    console.log(req.body)
    internalmark.findOne({ subjid: req.body.subjid,studentid:req.body.studentid}, (err, mark) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (mark) {
            return res.status(401).json({ 'msg': 'Mark Allready Entered' });
        }
      
            let newMark = internalmark(req.body);
            newMark.save((err, mark) => {
                if (err) {
                    console.log("err")
                    return res.status(400).json({ 'msg': err });
                }
                return res.status(201).json(mark);
            });

    });
};
exports.getinternals = (req, res) => {
    console.log(req.body)
    internalmark.find({ semester: req.body.semester,studentid:req.body.studentid}, (err, mark) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (mark) {
            return res.status(201).json(mark);
        }
    });
};