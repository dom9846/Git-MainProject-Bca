var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var rateTeacherSchema = new mongoose.Schema({
    id: {
        type:ObjectId,
    },
    studentid: {
        type:String
    },
    rating1: {
        type:String
    },
    rating2: {
        type:String
    },
    rating3: {
        type:String
    },
    overall: {
        type:String
    },
    date: {
        type:Date
    }
})
module.exports = mongoose.model("rateteacher", rateTeacherSchema);