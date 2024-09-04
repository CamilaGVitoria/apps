const { checkSchema } = require("express-validator")
const Notes = require('../model/Notes');

module.exports = {
    manipulateNotes: checkSchema({
        noteName:{
            trim: true,
        },
        noteText: {
        }
    })
};