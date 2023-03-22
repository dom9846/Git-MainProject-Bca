var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var rateStudentSchema = new mongoose.Schema({
    teacherid: {
        type:ObjectId,
    },
    studentid: {
        type:ObjectId,
    },
    rating: {
        type:String
    },
    date: {
        type:Date
    }
})
module.exports = mongoose.model("ratestudent", rateStudentSchema);