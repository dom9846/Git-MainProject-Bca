var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var marksSchema = new mongoose.Schema({
    subjid: {
        type: ObjectId
    },
    subname: {
        type: String
    },
    semester: {
        type: String
    },
    teachid: {
        type: ObjectId
    },
    teachfname: {
        type: String
    },
    teachsname: {
        type: String
    },
    studentid: {
        type: ObjectId
    },
    internalmark: {
        type: String,
    }
})
module.exports = mongoose.model("Internalmark", marksSchema);