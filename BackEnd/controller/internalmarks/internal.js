var internalmark = require("../../model/internalmarks/internal");
exports.internalMark = (req, res) => {
    console.log(req.body)
    internalmark.findOne({ subjid: req.body.subjid,Studentid:req.body.Studentid}, (err, mark) => {
        if (err) {
            // console.log("err")
            return res.status(400).json({ 'msg': err });
        }
        if (mark) {
            return res.status(400).json({ 'msg': 'Mark Allready Entered' });
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