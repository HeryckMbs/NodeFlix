// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();

exports.homeRoutes = function(req,res) {
    res.render('home/main')
}

exports.lojaHome = function(req,res){
    res.render('loja/index')
}

exports.teste =('/teste',async (req,res) =>{
    const teste = req.body.teste;
    let cog = await prisma.teste2.create(
        {data: {nTeste:teste}}
    )
    return res.json(cog);
})