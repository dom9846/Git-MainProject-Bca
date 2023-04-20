var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var assignrateTeacherSchema = new mongoose.Schema({
    teacherid: {
        type:ObjectId,
    },
    teachfname: {
        type:String,
    },
    teachsname: {
        type:String,
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