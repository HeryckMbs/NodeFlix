import express from "express";
import dotenv from "dotenv"
import morgan from "morgan";
import bodyParser from "body-parser";
import path from "path";
import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()
import {router} from './server/routes/router';
const app = express()

// app.use(morgan('tiny'))
// app.use(bodyParser.urlencoded({extended: true}))
app.use(express.json())


app.set("view engine","ejs")
app.use('views', express.static(path.resolve(__dirname+ "views")))
app.use('server', express.static(path.resolve(__dirname+"server")))
app.use('/assets', express.static(path.resolve(__dirname+"/assets")))
app.use('/node_modules', express.static(path.resolve(__dirname+"/node_modules")))

const db = require('./server/database/connection')
db.connectDb()
dotenv.config({path: '.env'})
const PORT = process.env.PORT || 8080;

//rotas
app.use(router)


app.listen(PORT,()=> console.log('Servidor ligado'))

app.route('/loja')