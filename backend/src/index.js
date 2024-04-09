const { app } = require('./app');
const { dbConection } = require('./db');

async function main() {
    //Primero nos conectamos a la base de datos
    await dbConection();
    //Despues inicio mi servidor 
    await app.listen(3000);
}

main();