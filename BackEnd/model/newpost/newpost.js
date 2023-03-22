var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var newpostSchema = new mongoose.Schema({
    id: {
        type:ObjectId,
    },
    comment: {
        type:String,
    },
    file: {
        type:String
    },
    datetime: {
        type:Date
    }
})
module.exports = mongoose.model("newpost", newpostSchema);