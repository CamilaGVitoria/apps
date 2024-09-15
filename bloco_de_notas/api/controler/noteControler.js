const Notes = require('../model/Notes');
const { validationResult, matchedData } = require('express-validator');

module.exports = {
    addNote: async (req, res) => {
        const erros = validationResult(req);
        if (!erros.isEmpty()) {
            res.json({
                error: erros.mapped()
            });
            return;
        }

        const data = matchedData(req);

        console.log(data)

      

        const newNote = new Notes({
            noteName: data.noteName,
            noteText: data.noteText ? data.noteText : " ",
            user: req.user.id
        });

        const info = await newNote.save();
        res.json({ info });

    },

    getNotes: async (req, res) => {
        try {
            const note = await Notes.find({ user: req.user.id });

            if (!note) {
                return res.status(404).json({
                    msg: 'Nota não encontrada',
                });
            }

            res.status(200).json({ note });

        } catch (error) {
            res.status(500).json({
                msg: 'Erro ao buscar a nota!',
                error: error.message
            });
        }
    },
    
    deleteNotes: async (req, res) => {
        const note = await Notes.findOneAndDelete({
            _id: req.params.id,
            user: req.user.id
        });

        if (!note) {
            res.json({
                res: "Nota não deletada!"
            });
            return;
        }
        res.json({
            res: "Nota deletada com sucesso!", note
        });

    },

    editNotes: async (req, res) => {
        const erros = validationResult(req);
        if (!erros.isEmpty()) {
            res.json({
                error: erros.mapped()
            });
            return;
        }

        const id = req.params.id;
        const { noteName, noteText } = req.body;


        const note = await Notes.findOneAndUpdate(
            { _id: req.params.id, user: req.user.id },
            { noteName: req.body.noteName, noteText: req.body.noteText },
            { new: true, runValidators: true }
        );

        res.json({ note });
    }
};