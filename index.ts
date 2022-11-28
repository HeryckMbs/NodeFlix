import express from "express";
import dotenv from "dotenv"
import morgan from "morgan";
import bodyParser from "body-parser";
import path from "path";
import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()

const app = express()

app.use(morgan('tiny'))

app.use(bodyParser.urlencoded({extended: true}))

app.set("view engine","ejs")
app.set('views', path.resolve(__dirname,"views"))
app.set('server', express.static(path.resolve(__dirname,"server")))
app.set('assets', express.static(path.resolve(__dirname,"assets")))

const db = require('./server/database/connection')
db.connectDb()
dotenv.config({path: '.env'})
const PORT = process.env.PORT || 8080;

//rotas
app.use('/',require('./server/routes/router'))


app.listen(PORT,()=> console.log('rodou'))
