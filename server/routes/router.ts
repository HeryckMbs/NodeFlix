import {Router} from "express";

import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const services = require('../services/render')
const router = Router()


router.get('/', services.homeRoutes)
router.get('/loja',services.lojaHome)

router.post('/teste',async (req,res) =>{
    const teste = req.body.teste;
    let cog = await prisma.teste2.create(
        {data: {nTeste:teste}}
    )
    return res.json(cog);
})


export { router}