var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var assignrateTeacherSchema = new mongoose.Schema({
    teacherid: {
        type:ObjectId,
    },
    year: {
        type:String
    },
    duedate: {
        type:Date
    },
    date: {
        type:Date
    }
})
module.exports = mongoose.model("assignrateteacher", assignrateTeacherSchema);