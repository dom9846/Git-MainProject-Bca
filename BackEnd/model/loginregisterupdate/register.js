var mongoose = require("mongoose");
var userSchema = new mongoose.Schema({
    identity: {
        type: Number,
        required: true,
        maxlength: 52,
    },
    firstname: {
        type: String,
        required: true
    },
    secondname: {
        type: String,
        required: true
    },
    user_type: {
        type: String,
        required: true
    },
    username: {
        type: String
    },
    password: {
        type: String
    }
    

})
module.exports = mongoose.model("User", userSchema);