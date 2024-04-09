const delitomodel = require('../models/delito.model');

class DelitoService {
    DelitoService() {}

    async consultardelitos() {
        try {

            return await delitomodel.find();
        } catch (error) {
            return error;

        }
    }
}

module.exports = new DelitoService();