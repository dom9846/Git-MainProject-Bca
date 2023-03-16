var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var attendanceSchema = new mongoose.Schema({
    subjid: {
        type: String
    },
    teachid: {
        type: ObjectId
    },
    studentid: {
        type: ObjectId
    },
    internalmark: {
        type: String,
    }
})
module.exports = mongoose.model("Internalmark", attendanceSchema);