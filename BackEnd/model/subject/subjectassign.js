var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var subjectAssignSchema = new mongoose.Schema({
    subid: {
        type: ObjectId,
    },
    subteacher: {
        type: ObjectId
    },
    subteacherfname: {
        type: String
    },
    subteachersname: {
        type: String
    }
})
module.exports = mongoose.model("subjectAssign", subjectAssignSchema);