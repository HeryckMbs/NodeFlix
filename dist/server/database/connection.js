"use strict";
const { Client } = require("pg");
const dotenv = require("dotenv");
dotenv.config();
const connectDb = async () => {
    try {
        const client = new Client({
            user: process.env.PGUSER,
            host: process.env.PGHOST,
            database: process.env.PGDATABASE,
            password: process.env.PGPASSWORD,
            port: process.env.PGPORT
        });
        await client.connect();
        console.log(client._connected == true ? 'Banco de dados Conectado!' : 'Erro ao conectar no banco de dados');
        await client.end();
    }
    catch (error) {
        console.log(error);
    }
};
module.exports = { connectDb };
//# sourceMappingURL=connection.js.map