/**
 * Múltiplos elementos dos documentos necessitam de um mesmo tipo de dado, que
 * é um conjunto de informações sobre aquele elemento, como nome, descrição e
 * data de criação
 */

DROP TYPE IF EXISTS Info;

CREATE TYPE Info AS (
    nome VARCHAR(50),
    descricao VARCHAR(100),
    data_criacao DATE
);
