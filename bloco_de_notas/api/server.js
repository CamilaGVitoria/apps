require('dotenv').config({ path: '.env' });
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const apiRouters = require('./router/routers');

// Conexão com o banco de dados
mongoose.connect(process.env.DATABASE, {
    useUnifiedTopology: true,
    useNewUrlParser: true
});
mongoose.Promise = global.Promise;
mongoose.connection.on('error', (error) => {
    console.error('Erro na conexão com o banco de dados:' + error.message);
});

const server = express();
server.use(express.json());
server.use(cors());
server.use('/', apiRouters);

server.listen(process.env.PORT, '0.0.0.0', () => {
    console.log(`Servidor rodando na porta: ${process.env.PORT}`);
});
