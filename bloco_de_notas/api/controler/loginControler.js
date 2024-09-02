const User = require('../model/User');
const { validationResult, matchedData } = require('express-validator');
const bcrypt = require('bcrypt');

module.exports = {
    addUser: async (req, res) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            res.status(422).json({ error: errors.mapped() });
            return;
        }
        
        const data = matchedData(req);
        const userExists = await User.findOne({ userName: data.userName });

        if (userExists) {
            res.status(422).json({
                msg: 'Nome de usuário já existe!'
            });
            return;
        }

        const salt = await bcrypt.genSalt(12);
        const passwordHash = await bcrypt.hash(data.password, salt);

        const newUser = new User({
            userName: data.userName,
            password: passwordHash
        });

        const user = await newUser.save();

        res.status(201).json({
            msg: 'Usuário criado com sucesso!'
        });

    },

    login: async (req, res) => {
        const { userName, password } = req.body;

        const user = await User.findOne({ userName });

        if (!user) {
            return res.status(404).json({
                msg: 'Usuário não encontrado!'
            });
        }

        const checkPassword = await bcrypt.compare(password, user.password);

        if (!checkPassword) {
            return res.status(422).json({
                msg: 'Senha incorreta!'
            });

        }
    },

    getUser: async (req, res) => {
        let id = req.params.id;
        const user = await User.findById(id, '-password');

        if (!user) {
            res.status(404).json({
                msg: 'Usuário não encontrado!'
            });
            return;
        }
        res.json({ user });
    },

    deleteUser: async (req, res) => {
        const id = req.params.id;
        const user = await User.findByIdAndDelete(id);

        if (!user) {
            res.status(404).json({
                res: 'Não foi possível deletar o usuário!'
            });
            return;
        }
        res.status(200).json({
            res: 'Usuário deletado com sucesso!', nameUser: user.userName
        });
    },

    editUser: async (req,res) => {
        const errors = validationResult(req);

        if(!errors.isEmpty()) {
            res.json({
                error: errors.mapped()
            });
            return;
        }
        const id = req.params.id;
        const { userName, password } = req.body;

        const data = matchedData(req);
        const salt = await bcrypt.genSalt(12);
        const passwordHash = await bcrypt.hash(data.password, salt);

        const user = await User.findByIdAndUpdate(
            id,
            { userName, password: passwordHash },
            { new: true, runValidators: true }
        );

        res.json({ user });
    }
};
