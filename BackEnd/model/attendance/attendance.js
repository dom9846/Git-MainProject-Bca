var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var attendanceSchema = new mongoose.Schema({
    semester: {
        type: String
    },
    date: {
        type: Date
    },
    period: {
        type: String
    },
    studentlist: {
        type: ObjectId
    },
})
module.exports = mongoose.model("Attendance", attendanceSchema);