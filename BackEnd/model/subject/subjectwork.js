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
    teacherid: {
        type:ObjectId
    },
    studentid: {
        type:ObjectId
    }
})
module.exports = mongoose.model("Subjectwork", subworkSchema);