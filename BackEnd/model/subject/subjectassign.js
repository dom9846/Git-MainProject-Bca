var mongoose = require("mongoose");
const { ObjectId } = mongoose.Schema;
var subjectAssignSchema = new mongoose.Schema({
    subid: {
        type: ObjectId,
    },
    year: {
        type: String
    },
    semester: {
        type: String
    },
    subteacher: {
        type: ObjectId
    }
})
module.exports = mongoose.model("subjectAssign", subjectAssignSchema);