var mongoose = require("mongoose");
var timeTableSchema = new mongoose.Schema({
    id: {
        type: String
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