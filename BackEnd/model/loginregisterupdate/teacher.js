var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var teacherSchema = new mongoose.Schema({
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
        type: String,
    },
    email: {
        type: String,
    },
    mobile: {
        type: String,
    },
    age: {
        type: String,
    },
    qualification:{
        type:String
    }
})
module.exports = mongoose.model("Teacher", teacherSchema);