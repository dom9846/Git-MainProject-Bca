var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var chatroomSchema = new mongoose.Schema({
    year: {
        type:String,
    },
    header: {
        type:String
    },
    owner: {
        type:ObjectId
    },
    participant: {
        type:ObjectId
    }
})
module.exports = mongoose.model("chatroom", chatroomSchema);