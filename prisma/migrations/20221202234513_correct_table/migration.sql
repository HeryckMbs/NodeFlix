-- AlterTable
CREATE SEQUENCE teste_id_seq;
ALTER TABLE "teste" ALTER COLUMN "id" SET DEFAULT nextval('teste_id_seq');
ALTER SEQUENCE teste_id_seq OWNED BY "teste"."id";
