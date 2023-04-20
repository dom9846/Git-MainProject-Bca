var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var subworkSchema = new mongoose.Schema({
    worktype: {
        type:String,
    },
    duedate: {
        type:Date
    },
    activity: {
        type:String
    },
    subjectid: {
        type:ObjectId
    },
    subjectname: {
        type:String
    },
    semester:{
        type:String
    },
    teacherid: {
        type:ObjectId
    },
    date: {
        type:Date
    },
})
module.exports = mongoose.model("Subjectwork", subworkSchema);