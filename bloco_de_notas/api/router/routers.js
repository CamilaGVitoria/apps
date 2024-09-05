const cors = require('cors');
const express = require('express');

const server = express();
server.use(cors()); 
server.use(express.json());

const router = express.Router();

const notesControler = require('../controler/noteControler');
const notesValidator = require('../validator/noteValidator');

const loginControler = require('../controler/loginControler');
const loginValidator = require('../validator/loginValidator');
const auth = require('../middleware/auth');

router.get('/ping', (req,res) => {
    res.json({retorno: true});
});

router.post('/notes/add/:id', auth, notesValidator.manipulateNotes, notesControler.addNote);
router.delete('/notes/:id', auth, notesControler.deleteNotes);
router.put('/notes/:id', auth, notesValidator.manipulateNotes, notesControler.editNotes);
router.get('/notes', auth, notesControler.getNotes);

router.post('/user/add', loginValidator.manipulateLogin, loginControler.addUser);
router.post('/user/login', loginControler.login);
router.delete('/user/:id', auth, loginControler.deleteUser);
router.put('/user/:id', auth, loginValidator.manipulateLogin, loginControler.editUser);
router.get('/user/:id', auth, loginControler.getUser);

module.exports = router;