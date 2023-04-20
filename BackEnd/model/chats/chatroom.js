var mongoose = require("mongoose");
var ChatRoomSchema = new mongoose.Schema({
    roomname: {
        type:String,
    },
    year: {
        type:String
    }
})
module.exports = mongoose.model("chatroom", ChatRoomSchema);