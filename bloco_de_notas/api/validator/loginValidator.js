const { checkSchema } = require("express-validator");

module.exports = {
    manipulateLogin: checkSchema({
        userName:{
            trim: true,
            notEmpty: {
                errorMessage: 'Informe um nome de usuário!'
            }
        },
        password: {
            notEmpty: {
                errorMessage: 'Informe uma senha!'
            },
            isLength: {
                options: {min: 6}
            },
            errorMessage: 'Mínimo de 6 caracteres.'
        }
    })
};
