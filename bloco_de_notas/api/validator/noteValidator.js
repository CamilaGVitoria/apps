const { checkSchema } = require("express-validator")

module.exports = {
    manipulateNotes: checkSchema({
        noteName:{
            trim: true,
        },
        noteText: {
        }
    })
};