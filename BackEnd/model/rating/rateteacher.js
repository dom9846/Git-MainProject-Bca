var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var rateTeacherSchema = new mongoose.Schema({
    id: {
        type:String,
    },
    teacherid: {
        type:ObjectId,
    },
    rating: {
        type:Array
    },
    date: {
        type:Date
    },
    overall: {
        type:String
    }
})
module.exports = mongoose.model("rateteacher", rateTeacherSchema);