import { request, response, Router } from "express";
import { PrismaClient } from "@prisma/client";
const prisma: PrismaClient = new PrismaClient();
const homeController = require('../controller/HomeController')
const LojaController = require('../controller/loja/LojaController')
const router: Router = Router()

router.get('/', homeController.homeRoutes);

/*
    ROTAS DE DADOS
*/
// router.get('/get_endereco', async (request, response) => {
//     const enderecos = await prisma.endereco.findMany({
//         // where:{
//         //     e_ : true
//         // }
//     })
//     console.log(enderecos)
//     response.json(enderecos)
// })


/**
 * Rotas da LOJA
 */
router.route('/loja')
    .get(LojaController.lojaHome)
    .post(LojaController.lojaCreate)
    .put(LojaController.lojaUpdate);
router.get('/get_data_loja', LojaController.lojaDatatable);
router.get('/detalhes/:id', LojaController.lojaDetalhes);
router.delete('/:id', LojaController.lojaDelete);


export { router }