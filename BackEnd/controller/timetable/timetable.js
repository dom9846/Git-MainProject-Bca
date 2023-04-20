var timetable = require("../../model/timetable/timetable");
const {ObjectId}=require('mongodb');
exports.timetableupdate = (req, res) => {
    // console.log(req.body)

    timetable.findOne({ identity: req.body.identity }, (err, user) => {
        console.log(user)
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (user) {
            timetable.updateOne( 
                { _id: ObjectId(user._id) }, 
                {
                  $set: 
                    {
                        year1:req.body.year1,
                        year2:req.body.year2,
                        year3:req.body.year3,
                    }
                },(err,u)=>{
                    if(err){
                        return res.status(400).json({ 'msg': err });
                    }
                    if(u){
                        return res.status(201).json({ 'msg': u });
                    }
                } 
            )
        }else{
            let newUser = timetable(req.body);
            newUser.save((err, user) => {
                if (err) {
                    return res.status(400).json({ 'msg': err });
                }
                else if(user){
                    return res.status(201).json({'msg': "Successfully Added"});
                }
            });      
        }
    });
};
// exports.timetableadd = (req, res) => {
//     console.log(req.body)
//     timetable.findOne({ identity: req.body.identity }, (err, user) => {
//         if (err) {
//             // console.log("err")
//             return res.status(400).json({ 'msg': err });
//         }
//         if (user) {
//             return res.status(400).json({ 'msg': 'Try later' });
//         }
//         let newUser = timetable(req.body);
//         newUser.save((err, user) => {
//             if (err) {
//                 return res.status(400).json({ 'msg': err });
//             }
//             else if(user){
//                 return res.status(201).json({'msg': "Successfully Added"});
//             }
//         });

//     });
// };

exports.timetableretrieve = (req, res) => {
    console.log(req.body)
    timetable.find((err, timetable) => {
        if (err) {
            return res.status(400).json({ 'msg': err });
        }
        if (timetable) {
            return res.status(201).json(timetable);
        }
        return res.status(404).json({ 'msg': 'Couldnt Fetch details' });
    });
};