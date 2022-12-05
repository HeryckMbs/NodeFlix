import { NextFunction, Request, Response } from "express";
import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()

exports.lojaHome = function(req: Request,res: Response, next: NextFunction){
 

    res.render('loja/index')
}
exports.lojaDatatable = async function(req: Request,res: Response, next: NextFunction){
    let draw = req.query.draw;

    let a = await prisma.loja.findMany({include: {
        endereco: true,
        funcionario: true
    }});
    console.log(a[0])
    let output = {
        'draw' : draw,
        'iTotalRecords' : a.length,
        'iTotalDisplayRecords': a.length,
        'data' : a
    }
    console.log(output)
    res.json(output)
}

exports.lojaDetalhes = (req: Request,res: Response) => {
    res.send(req.params.id)
}

exports.lojaCreate = (req: Request,res: Response) =>{
    res.send('post')
}

exports.lojaUpdate = (req: Request,res: Response) =>{
    res.send('update')
}

exports.lojaDelete = (req: Request,res: Response) => {
    res.send('delete')
}