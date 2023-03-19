var mongoose = require("mongoose");
var subjectSchema = new mongoose.Schema({
    subjectname: {
        type:String,
    },
    subjecttype: {
        type:String
    },
    year: {
        type:String
    },
    semester: {
        type:String
    }
})
module.exports = mongoose.model("Subject", subjectSchema);