var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var chatSchema = new mongoose.Schema({
    id: {
        type:ObjectId,
    },
    sender: {
        type:ObjectId,
    },
    senderfname: {
        type:String,
    },
    sendersname: {
        type:String,
    },
    senderutype: {
        type:String,
    },
    message: {
        type:String
    },
    date: {
        type:Date
    },
})
module.exports = mongoose.model("chat", chatSchema);