import {Router} from "express";

import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();
const homeController = require('../controller/HomeController')
const LojaController = require('../controller/loja/LojaController')
const router = Router()

router.get('/', homeController.homeRoutes);

/**
 * Rotas da LOJA
 */
router.route('/loja')
    .get(LojaController.lojaHome)
    .post(LojaController.lojaCreate)
    .put(LojaController.lojaUpdate);
router.get('/detalhes/:id',LojaController.lojaDetalhes)
router.delete('/:id',LojaController.lojaDelete);


export {router}