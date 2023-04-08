var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var studentSchema = new mongoose.Schema({
    id: {
        type: ObjectId
    },
    fname:{
        type: String
    },
    sname:{
        type: String
    },
    propic: {
        type: String
    },
    rollno:{
        type: String
    },
    email: {
        type: String,
    },
    mobile: {
        type: Number
    },
    age: {
        type: Number,
    },
    parent: {
        type: String,
    },
    parentcontact: {
        type: Number,
    },
    year: {
        type:Number
    },
    semester: {
        type:Number
    }
})
module.exports = mongoose.model("Student", studentSchema);