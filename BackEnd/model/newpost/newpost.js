var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var newpostSchema = new mongoose.Schema({
    post: {
        type:String,
    },
    comment: {
        type:String,
    },
    userid: {
        type:ObjectId,
    },
    userpic:{
        type:String
    },
    userfname:{
        type:String
    },
    usersname:{
        type:String
    },
    datetime: {
        type:Date
    }
})
module.exports = mongoose.model("newpost", newpostSchema);