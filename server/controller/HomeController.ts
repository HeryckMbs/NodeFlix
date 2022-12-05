// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();

import { Request, Response } from "express"

exports.homeRoutes = function(req: Request,res: Response) {
    res.render('home/main')
}

exports.lojaHome = function(req: Request,res: Response){
    res.render('loja/index')
}

