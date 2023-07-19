const express = require("express");
const User = require("../models/user");
const e = require("express");

const bcryptjs=require("bcryptjs");

const authRouter = express.Router();
authRouter.post("/api/singup", async (req, res) => {


    try {
        const { name, adderss, email, password } = req.body;
        const existingUSer = await User.findOne({ email });
        if (existingUSer) {

         return   res.status(400).json({ msg: "E_mail already Exists" });

        }
    const hashPassword = await  bcryptjs.hash(password,8);
        let user = new User({
            name,
            adderss,
            email,
            password:hashPassword,
        });
        user =await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({
            error: e.message });
       
    }
});
module.exports = authRouter;