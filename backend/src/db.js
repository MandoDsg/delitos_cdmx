const mongose = require('mongoose');
const dbConection = async() => {
    try {
        console.log('Conectando DB...');
        await mongose.connect('mongodb://127.0.0.1:27017/servicio_social', {});
        console.log('CONECTADO...');

    } catch (error) {

        throw new Error(error);

    }
}

module.exports = {
    dbConection
};