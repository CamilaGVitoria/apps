const jwt = require('jsonwebtoken');

module.exports = (req, res, next) => {
    const token = req.header('Authorization')?.replace('Bearer ', '');

    if (!token) {
        return res.status(401).json({
            msg: 'Acesso negado!'
        });
    }

    try {
        const secret = process.env.SECRET;
        const decoded = jwt.verify(token, secret);

        req.user = decoded;
        next();
    } catch (error) {
        res.status(400).json({
            msg: 'Token inválido!'
        });
    }
};