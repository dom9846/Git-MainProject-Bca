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
    absentstudentlist: {
        type: Array
    },
})
module.exports = mongoose.model("Attendance", attendanceSchema);