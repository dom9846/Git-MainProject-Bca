var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var adminSchema = new mongoose.Schema({
    id: {
        type: ObjectId
    },
    propic: {
        type: String
    },
    email: {
        type: String,
    },
    mobile: {
        type: Number,
    },
    age: {
        type: Number,
    },
    qualification: {
        type: String,
    },

})
module.exports = mongoose.model("Admin", adminSchema);