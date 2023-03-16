var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var teacherSchema = new mongoose.Schema({
    id: {
        type: ObjectId
    },
    propic: {
        type: String,
    },
    email: {
        type: String,
    },
    age: {
        type: String,
    },
    mobile: {
        type: String,
    },
    qualification:{
        type:String
    }
})
module.exports = mongoose.model("Teacher", teacherSchema);