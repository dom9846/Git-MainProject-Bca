var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var timeTableSchema = new mongoose.Schema({
    identity: {
        type: ObjectId
    },
    year1: {
        type: String
    },
    year2: {
        type: String
    },
    year3: {
        type: String
    }
})
module.exports = mongoose.model("TimeTable", timeTableSchema);