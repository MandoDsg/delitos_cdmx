const delitoService = require('../services/delito.service');

const consultardelitos = async(req, res) => {
    res.json({
        delitos: await delitoService.consultardelitos()
    })
}


module.exports = {consultardelitos};