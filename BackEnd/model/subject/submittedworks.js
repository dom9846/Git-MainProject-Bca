var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var submittedworkSchema = new mongoose.Schema({
    id: {
        type:ObjectId,
    },
    studentid: {
        type:ObjectId
    },
    studentfname: {
        type:String
    },
    studentsname: {
        type:String
    },
    semester: {
        type:String
    },
    workfile: {
        type:String
    },
    date: {
        type:Date
    }
})
module.exports = mongoose.model("submittedworks", submittedworkSchema);