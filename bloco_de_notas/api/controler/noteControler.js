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

        const newNote = new Notes({
            noteName: data.noteName,
            noteText: data.noteText
        });

        const info = await newNote.save();
        res.json({ info });

    },

    getNote: async (req, res) => {
        let id = req.params.id;
        const note = await Notes.findById(id);

        if (note == null) {
            res.json({
                res: "Nota não encontrada", note
            });
            return;
        }
        res.json({ note })
    },

    deleteNotes: async (req, res) => {
        let id = req.params.id;
        const note = await Notes.findByIdAndDelete(id);

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


        const note = await Notes.findByIdAndUpdate(
            id,
            { noteName, noteText },
            { new: true, runValidators: true }
        );

        res.json({ note });
    }
};