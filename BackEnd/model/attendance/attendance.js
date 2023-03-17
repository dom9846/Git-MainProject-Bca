var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var attendanceSchema = new mongoose.Schema({
    year: {
        type: String
    },
    semester: {
        type: String
    },
    date: {
        type: String
    },
    period: {
        type: String
    },
    studentid: {
        type: ObjectId
    },
})
module.exports = mongoose.model("Internalmark", attendanceSchema);