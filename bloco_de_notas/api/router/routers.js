const express = require ('express');
const router = express.Router();

const notesControler = require('../controler/noteControler');
const notesValidator = require('../validator/noteValidator');

const loginControler = require('../controler/loginControler');
const loginValidator = require('../validator/loginValidator');

router.get('/ping', (req,res) => {
    res.json({retorno: true});
});

router.post('/notes/add', notesValidator.manipulateNotes, notesControler.addNote);
router.post('/user/add', loginValidator.manipulateLogin, loginControler.addUser);

router.delete('/notes/:id', notesControler.deleteNotes);
router.delete('/user/:id', loginControler.deleteUser);

router.put('/notes/:id', notesValidator.manipulateNotes, notesControler.editNotes);
router.put('/user/:id', loginValidator.manipulateLogin, loginControler.editUser);

router.get('/notes/:id', notesControler.getNote);
router.get('/user/:id', loginControler.getUser);
module.exports = router;