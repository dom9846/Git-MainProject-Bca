var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var chatroomSchema = new mongoose.Schema({
    roomname: {
        type:String,
    },
    year: {
        type:String
    }
})
module.exports = mongoose.model("chatroom", chatroomSchema);