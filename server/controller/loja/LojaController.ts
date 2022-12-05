import { NextFunction, Request, Response } from "express";
import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()

type LojaRequest = {
    endereco: string,
    endereco2: string,
    bairro: string,
    cidade: Number,
    cep: string,
    telefone: string,
    ultima_atualizacao:string,
    e_loja: boolean
}

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

exports.lojaCreate = async (req: Request,res: Response) =>{
    const {endereco,bairro,cep,telefone} = req.body
    const cidade: Number = parseInt(req.body.cidade)
    const endereco_data: LojaRequest = {
        endereco: String(endereco),
        endereco2: '',
        bairro: String(bairro),
        cidade: (cidade),
        cep: String(cep),
        telefone: String(telefone),
        ultima_atualizacao:  new Date().toLocaleString(),
        e_loja: true

}
    const endereco_loja = await prisma.endereco.create({
        data: endereco_data
    });

    console.log(endereco_loja)
// console.log(endereco_loja)
    // const data = {
    //     gerende_id : parseInt(req.body.gerente),
    //     endereco_id: parseInt(endereco_loja.endereco_id)
    // }
    // console.log(data)
    return res.json(endereco_loja)
}

exports.lojaUpdate = (req: Request,res: Response) =>{
    res.send('update')
}

exports.lojaDelete = (req: Request,res: Response) => {
    res.send('delete')
}