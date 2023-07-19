const mongoose = require("mongoose");
const authRouter = require("../routes/auth");

const userSchema = mongoose.Schema({


    name: {
        type: String,
        required: true,
        trim: true
    },
    email: {
        type: String,
        required: true,
        trim: true,
        validate: {
            validator: (val) => {

                const re =
                    /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return val.match(re);

            },
            message: "please Enter valid E_mail",
        }

    },
    password: {
        type: String,
        required: true,
    },
   
    address: {
        type: String,
        default: "",
    },
    type: {
        type: String,
        default: "user",

    },

});

const User = mongoose.model("User",userSchema);
module.exports=User;