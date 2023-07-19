
//api
const express = require("express");

const PORT = 3000;
const app = express();
const authRouter = require("./routes/auth");
const mongoose = require("mongoose");
const DB = "mongodb+srv://mh2023:167349193462@cluster0.j3xcbjq.mongodb.net/?retryWrites=true&w=majority";

app.use(express.json());
app.use(authRouter);

mongoose.connect(DB).then(() => {
    console.log("successful");
}).catch((e)=>{
    console.log(e);

});

app.listen(PORT, "0.0.0.0", function () {
    console.log('conected to port: ' + PORT);
});