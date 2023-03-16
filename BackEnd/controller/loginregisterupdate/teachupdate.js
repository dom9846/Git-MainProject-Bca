// var Teacher = require('../../model/loginregisterupdate/teacher');
// const {ObjectId}=require('mongodb');
// exports.teacherupdate = (req, res) => {
//     console.log(req.body)

//     Teacher.findOne({ id: req.body.id }, (err, user) => {
//         if (err) {
//             // console.log("err")
//             return res.status(400).json({ 'msg': err });
//         }
//         if (user) {
//             Teacher.updateOne( 
//                 { _id: ObjectId(user._id) }, 
//                 {
//                   $set: 
//                     {
//                         propic:req.body.propic,
//                         email:req.body.email,
//                         age:req.body.age,
//                         mobile:req.body.mobile,
//                         qualification:req.body.qualification,
//                     }
//                 },(err,u)=>{
//                     if(err){
//                         return res.status(400).json({ 'msg': "Error occured"});
//                     }
//                     if(u){
//                         return res.status(201).json({ 'msg': "Profile Updated"});
//                     }
//                 } 
//             )
//         }
//     });
// };