const { Schema, model } = require('mongoose');
const delitoSchema = new Schema({
    delito: String,
    categoria_delito: String,
    colonia_hecho: String,
    alcaldia_hecho: String,
    delito_codigo: Number,
    categoria_delito_codigo: Number,
    colonia_hecho_codigo: Number,
    alcaldia_hecho_codigo: Number,
})

module.exports = model('Delito', delitoSchema);