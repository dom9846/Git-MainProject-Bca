require("dotenv").config();
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const cors = require("cors");
const express = require('express')
const app = express()
const port = 3000

var registerRoutes = require('./routes/loginregisterupdate/register');
var loginRoutes = require('./routes/loginregisterupdate/login');
var studentRoutes = require('./routes/loginregisterupdate/student');
var teacherRoutes = require('./routes/loginregisterupdate/teacher');
var adminRoutes = require('./routes/loginregisterupdate/admin');
var internalmarkRoutes = require('./routes/internalmarks/internal');
var subjectAddRoutes = require('./routes/subject/subject');
var subjectAssignRoutes = require('./routes/subject/subjectassign');

//DB Connection
mongoose.set('strictQuery', true);
mongoose.connect(process.env.DATABASE, {
 useNewUrlParser: true,
 useUnifiedTopology: true
}
).then(() => {
    console.log("DB CONNECTED");
});

app.use(bodyParser.json());
app.use(cookieParser());
app.use(cors());

app.use('/api', registerRoutes);
app.use('/api', loginRoutes);
app.use('/api', studentRoutes);
app.use('/api', teacherRoutes);
app.use('/api', adminRoutes);
app.use('/api', internalmarkRoutes);
app.use('/api', subjectAddRoutes);
app.use('/api', subjectAssignRoutes);

app.get('/', (req, res) => {
 res.send('Hello World!')
})
app.listen(port, () => {
 console.log(`Example app listening on port ${port}`)
})