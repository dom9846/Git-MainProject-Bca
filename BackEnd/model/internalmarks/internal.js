var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var marksSchema = new mongoose.Schema({
    subjid: {
        type: ObjectId
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
module.exports = mongoose.model("Internalmark", marksSchema);