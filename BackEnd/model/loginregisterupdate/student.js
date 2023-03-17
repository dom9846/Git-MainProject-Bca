var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var studentSchema = new mongoose.Schema({
    id: {
        type: ObjectId
    },
    propic: {
        type: String,
        maxlength: 52
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