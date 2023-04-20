var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var rateStudentSchema = new mongoose.Schema({
    teacherid: {
        type:ObjectId,
    },
    teachfname: {
        type:String,
    },
    teachsname: {
        type:String,
    },
    subjectid: {
        type:ObjectId,
    },
    subname: {
        type:String,
    },
    semester: {
        type:String,
    },
    studentid: {
        type:ObjectId,
    },
    rating: {
        type:String
    }
})
module.exports = mongoose.model("ratestudent", rateStudentSchema);