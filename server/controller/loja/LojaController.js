

exports.lojaHome = function(req,res){
    res.render('loja/index')
}

exports.lojaDetalhes = (req,res) => {
    res.send(req.params.id)
}

exports.lojaCreate = (req,res) =>{
    res.send('post')
}

exports.lojaUpdate = (req,res) =>{
    res.send('update')
}

exports.lojaDelete = (req,res) => {
    res.send('delete')
}