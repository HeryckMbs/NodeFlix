"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const dotenv_1 = __importDefault(require("dotenv"));
const body_parser_1 = __importDefault(require("body-parser"));
const path_1 = __importDefault(require("path"));
const client_1 = require("@prisma/client");
const prisma = new client_1.PrismaClient();
const router_1 = require("./server/routes/router");
const app = (0, express_1.default)();
// app.use(morgan('tiny'))
app.use(body_parser_1.default.urlencoded({ extended: true }));
app.use(express_1.default.json());
app.set("view engine", "ejs");
app.use('views', express_1.default.static(path_1.default.resolve(__dirname + "views")));
app.use('server', express_1.default.static(path_1.default.resolve(__dirname + "server")));
app.use('/assets', express_1.default.static(path_1.default.resolve(__dirname + "/assets")));
app.use('/node_modules', express_1.default.static(path_1.default.resolve(__dirname + "/node_modules")));
const db = require('./server/database/connection');
db.connectDb();
dotenv_1.default.config({ path: '.env' });
const PORT = process.env.PORT || 8080;
//rotas
app.use(router_1.router);
app.listen(PORT, () => console.log('Servidor ligado'));
app.route('/loja');
//# sourceMappingURL=index.js.map