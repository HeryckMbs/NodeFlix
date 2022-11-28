-- CreateEnum
CREATE TYPE "enumclassificacao" AS ENUM ('G', 'PG', 'PG-13', 'R', 'NC-17');

-- CreateEnum
CREATE TYPE "enumrecursosespeciais" AS ENUM ('Trailers', 'Commentaries', 'Deleted Scenes', 'Behind the Scenes');

-- CreateTable
CREATE TABLE "aluguel" (
    "aluguel_id" SERIAL NOT NULL,
    "data_de_aluguel" DATE NOT NULL,
    "inventario_id" INTEGER NOT NULL,
    "cliente_id" INTEGER NOT NULL,
    "data_de_devolucao" DATE,
    "funcionario_id" INTEGER NOT NULL,
    "ultima_atualizacao" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "aluguel_pkey" PRIMARY KEY ("aluguel_id")
);

-- CreateTable
CREATE TABLE "ator" (
    "ator_id" SERIAL NOT NULL,
    "primeiro_nome" VARCHAR(45) NOT NULL,
    "ultimo_nome" VARCHAR(45) NOT NULL,
    "ultima_atualizacao" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ator_pkey" PRIMARY KEY ("ator_id")
);

-- CreateTable
CREATE TABLE "categoria" (
    "categoria_id" SERIAL NOT NULL,
    "nome" VARCHAR(25) NOT NULL,
    "ultima_atualizacao" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "categoria_pkey" PRIMARY KEY ("categoria_id")
);

-- CreateTable
CREATE TABLE "cidade" (
    "cidade_id" SERIAL NOT NULL,
    "cidade" VARCHAR(50) NOT NULL,
    "pais_id" INTEGER NOT NULL,
    "ultima_atualizacao" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "cidade_pkey" PRIMARY KEY ("cidade_id")
);

-- CreateTable
CREATE TABLE "cliente" (
    "cliente_id" SERIAL NOT NULL,
    "loja_id" INTEGER NOT NULL,
    "primeiro_nome" VARCHAR(45) NOT NULL,
    "ultimo_nome" VARCHAR(45) NOT NULL,
    "email" VARCHAR(50),
    "endereco_id" INTEGER NOT NULL,
    "ativo" VARCHAR(1) NOT NULL DEFAULT '1',
    "data_criacao" DATE NOT NULL,
    "ultima_atualizacao" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "cliente_pkey" PRIMARY KEY ("cliente_id")
);

-- CreateTable
CREATE TABLE "endereco" (
    "endereco_id" SERIAL NOT NULL,
    "endereco" VARCHAR(50) NOT NULL,
    "endereco2" VARCHAR(50),
    "bairro" VARCHAR(50) NOT NULL,
    "cidade_id" INTEGER NOT NULL,
    "cep" VARCHAR(10),
    "telefone" VARCHAR(20) NOT NULL,
    "ultima_atualizacao" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "endereco_pkey" PRIMARY KEY ("endereco_id")
);

-- CreateTable
CREATE TABLE "filme" (
    "filme_id" SERIAL NOT NULL,
    "titulo" VARCHAR(255) NOT NULL,
    "descricao" TEXT,
    "ano_de_lancamento" VARCHAR(4),
    "idioma_id" INTEGER NOT NULL,
    "idioma_original_id" INTEGER,
    "duracao_da_locacao" INTEGER NOT NULL DEFAULT 3,
    "preco_da_locacao" DECIMAL(4,2) NOT NULL DEFAULT 4.99,
    "duracao_do_filme" INTEGER,
    "custo_de_substituicao" DECIMAL(5,2) NOT NULL DEFAULT 19.99,
    "classificacao" "enumclassificacao" DEFAULT 'G',
    "recursos_especiais" "enumrecursosespeciais"[],
    "ultima_atualizacao" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "filme_pkey" PRIMARY KEY ("filme_id")
);

-- CreateTable
CREATE TABLE "filme_ator" (
    "ator_id" INTEGER NOT NULL,
    "filme_id" INTEGER NOT NULL,
    "ultima_atualizacao" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "filme_ator_pkey" PRIMARY KEY ("ator_id","filme_id")
);

-- CreateTable
CREATE TABLE "filme_categoria" (
    "filme_id" INTEGER NOT NULL,
    "categoria_id" INTEGER NOT NULL,
    "ultima_atualizacao" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "filme_categoria_pkey" PRIMARY KEY ("filme_id","categoria_id")
);

-- CreateTable
CREATE TABLE "filme_texto" (
    "filme_id" INTEGER NOT NULL,
    "titulo" VARCHAR(255) NOT NULL,
    "descricao" TEXT,

    CONSTRAINT "filme_texto_pkey" PRIMARY KEY ("filme_id")
);

-- CreateTable
CREATE TABLE "funcionario" (
    "funcionario_id" SERIAL NOT NULL,
    "primeiro_nome" VARCHAR(45) NOT NULL,
    "ultimo_nome" VARCHAR(45) NOT NULL,
    "endereco_id" INTEGER NOT NULL,
    "foto" OID,
    "email" VARCHAR(50),
    "loja_id" INTEGER NOT NULL,
    "ativo" VARCHAR(1) NOT NULL DEFAULT '1',
    "usuario" VARCHAR(16) NOT NULL,
    "senha" VARCHAR(40),
    "ultima_atualizacao" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "funcionario_pkey" PRIMARY KEY ("funcionario_id")
);

-- CreateTable
CREATE TABLE "idioma" (
    "idioma_id" SERIAL NOT NULL,
    "nome" VARCHAR(20) NOT NULL,
    "ultima_atualizacao" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "idioma_pkey" PRIMARY KEY ("idioma_id")
);

-- CreateTable
CREATE TABLE "inventario" (
    "inventario_id" SERIAL NOT NULL,
    "filme_id" INTEGER NOT NULL,
    "loja_id" INTEGER NOT NULL,
    "ultima_atualizacao" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "inventario_pkey" PRIMARY KEY ("inventario_id")
);

-- CreateTable
CREATE TABLE "loja" (
    "loja_id" SERIAL NOT NULL,
    "gerente_id" INTEGER NOT NULL,
    "endereco_id" INTEGER NOT NULL,
    "ultima_atualizacao" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "loja_pkey" PRIMARY KEY ("loja_id")
);

-- CreateTable
CREATE TABLE "pagamento" (
    "pagamento_id" INTEGER NOT NULL,
    "cliente_id" INTEGER NOT NULL,
    "funcionario_id" INTEGER NOT NULL,
    "aluguel_id" INTEGER,
    "valor" DECIMAL(5,2) NOT NULL,
    "data_de_pagamento" DATE NOT NULL,
    "ultima_atualizacao" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "pagamento_pkey" PRIMARY KEY ("pagamento_id")
);

-- CreateTable
CREATE TABLE "pais" (
    "pais_id" SERIAL NOT NULL,
    "pais" VARCHAR(50) NOT NULL,
    "ultima_atualizacao" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "pais_pkey" PRIMARY KEY ("pais_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "aluguel_data_de_aluguel_inventario_id_cliente_id_key" ON "aluguel"("data_de_aluguel", "inventario_id", "cliente_id");

-- AddForeignKey
ALTER TABLE "aluguel" ADD CONSTRAINT "fk_aluguel_cliente" FOREIGN KEY ("cliente_id") REFERENCES "cliente"("cliente_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "aluguel" ADD CONSTRAINT "fk_aluguel_funcionario" FOREIGN KEY ("funcionario_id") REFERENCES "funcionario"("funcionario_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "aluguel" ADD CONSTRAINT "fk_aluguel_inventario" FOREIGN KEY ("inventario_id") REFERENCES "inventario"("inventario_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cidade" ADD CONSTRAINT "fk_cidade_pais" FOREIGN KEY ("pais_id") REFERENCES "pais"("pais_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cliente" ADD CONSTRAINT "fk_cliente_endereco" FOREIGN KEY ("endereco_id") REFERENCES "endereco"("endereco_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cliente" ADD CONSTRAINT "fk_cliente_loja" FOREIGN KEY ("loja_id") REFERENCES "loja"("loja_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "endereco" ADD CONSTRAINT "fk_endereco_cidade" FOREIGN KEY ("cidade_id") REFERENCES "cidade"("cidade_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "filme" ADD CONSTRAINT "fk_filme_idioma" FOREIGN KEY ("idioma_id") REFERENCES "idioma"("idioma_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "filme" ADD CONSTRAINT "fk_filme_idioma_original" FOREIGN KEY ("idioma_original_id") REFERENCES "idioma"("idioma_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "filme_ator" ADD CONSTRAINT "fk_filme_ator_ator" FOREIGN KEY ("ator_id") REFERENCES "ator"("ator_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "filme_ator" ADD CONSTRAINT "fk_filme_ator_filme" FOREIGN KEY ("filme_id") REFERENCES "filme"("filme_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "filme_categoria" ADD CONSTRAINT "fk_filme_categoria_categoria" FOREIGN KEY ("categoria_id") REFERENCES "categoria"("categoria_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "filme_categoria" ADD CONSTRAINT "fk_filme_categoria_filme" FOREIGN KEY ("filme_id") REFERENCES "filme"("filme_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "funcionario" ADD CONSTRAINT "fk_funcionario_endereco" FOREIGN KEY ("endereco_id") REFERENCES "endereco"("endereco_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "funcionario" ADD CONSTRAINT "fk_funcionario_loja" FOREIGN KEY ("loja_id") REFERENCES "loja"("loja_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventario" ADD CONSTRAINT "fk_inventario_filme" FOREIGN KEY ("filme_id") REFERENCES "filme"("filme_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventario" ADD CONSTRAINT "fk_inventario_loja" FOREIGN KEY ("loja_id") REFERENCES "loja"("loja_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "loja" ADD CONSTRAINT "fk_loja_endereco" FOREIGN KEY ("endereco_id") REFERENCES "endereco"("endereco_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pagamento" ADD CONSTRAINT "fk_pagamento_aluguel" FOREIGN KEY ("aluguel_id") REFERENCES "aluguel"("aluguel_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pagamento" ADD CONSTRAINT "fk_pagamento_cliente" FOREIGN KEY ("cliente_id") REFERENCES "cliente"("cliente_id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pagamento" ADD CONSTRAINT "fk_pagamento_funcionario" FOREIGN KEY ("funcionario_id") REFERENCES "funcionario"("funcionario_id") ON DELETE NO ACTION ON UPDATE CASCADE;

