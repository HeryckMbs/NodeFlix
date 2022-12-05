"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const client_1 = require("@prisma/client");
const prisma = new client_1.PrismaClient();
exports.lojaHome = function (req, res, next) {
    res.render('loja/index');
};
exports.lojaDatatable = async function (req, res, next) {
    let draw = req.query.draw;
    let a = await prisma.loja.findMany({ include: {
            endereco: true,
            funcionario: true
        } });
    console.log(a[0]);
    let output = {
        'draw': draw,
        'iTotalRecords': a.length,
        'iTotalDisplayRecords': a.length,
        'data': a
    };
    console.log(output);
    res.json(output);
};
exports.lojaDetalhes = (req, res) => {
    res.send(req.params.id);
};
exports.lojaCreate = async (req, res) => {
    const { endereco, bairro, cidade, cep, telefone } = req.body;
    const endereco_loja = await prisma.endereco.create({
        data: {
            endereco: String(endereco),
            endereco2: '',
            bairro: String(bairro),
            cidade: (cidade),
            cep: String(cep),
            telefone: String(telefone),
            ultima_atualizacao: new Date().toLocaleString(),
            e_loja: true
        }
    });
    console.log(endereco_loja);
    // console.log(endereco_loja)
    // const data = {
    //     gerende_id : parseInt(req.body.gerente),
    //     endereco_id: parseInt(endereco_loja.endereco_id)
    // }
    // console.log(data)
    return res.json(endereco_loja);
};
exports.lojaUpdate = (req, res) => {
    res.send('update');
};
exports.lojaDelete = (req, res) => {
    res.send('delete');
};
//# sourceMappingURL=LojaController.js.map