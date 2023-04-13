/**
 * Remoção de tabelas e tipos
 *
 * A remoção de tabelas e tipos é feita das últimas definições para as primeiras
 * para evitar problemas de dependência entre tabelas e tipos
 */

DROP TABLE IF EXISTS slide;
DROP TABLE IF EXISTS apresentacao;
DROP TABLE IF EXISTS resposta;
DROP TABLE IF EXISTS pergunta;
DROP TABLE IF EXISTS formulario;
DROP TABLE IF EXISTS bloco_texto;
DROP TABLE IF EXISTS documento_texto;
DROP TYPE IF EXISTS FONTE;
DROP TABLE IF EXISTS celula;
DROP TABLE IF EXISTS planilha;
DROP TABLE IF EXISTS contribuicao;
DROP TABLE IF EXISTS documento;
DROP TYPE IF EXISTS TIPO_DOCUMENTO;
DROP TABLE IF EXISTS amizade;
DROP TABLE IF EXISTS usuario;

/**
 * Criação de tabelas e tipos 
 *
 * As tabelas foram criadas com base no mapeamento do modelo conceitual do banco
 * de dados para o modelo relacional
 */

CREATE TABLE usuario (
    id serial primary key,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_nasc date NOT NULL,
    data_ingresso date NOT NULL DEFAULT CURRENT_DATE 
);

CREATE TABLE amizade (
    id_remetente INT NOT NULL REFERENCES usuario(id),
    id_destinatario INT NOT NULL REFERENCES usuario(id),
    PRIMARY KEY (id_remetente, id_destinatario)
);

CREATE TYPE TIPO_DOCUMENTO AS ENUM (
    'PLANILHA',
    'FORMULARIO',
    'DOCUMENTO_TEXTO',
    'APRESENTACAO'
);

CREATE TABLE documento (
    id serial primary key,
    tipo TIPO_DOCUMENTO NOT NULL,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    data_criacao date NOT NULL DEFAULT CURRENT_DATE,
    id_dono INT NOT NULL REFERENCES usuario(id)
);

CREATE TABLE contribuicao (
    id_documento INT NOT NULL REFERENCES documento(id),
    id_usuario INT NOT NULL REFERENCES usuario(id), 
    PRIMARY KEY (id_documento, id_usuario)
);

CREATE TABLE planilha (
    id_documento INT PRIMARY KEY REFERENCES documento(id),
    largura_linhas INT NOT NULL,
    largura_colunas INT NOT NULL,
    CHECK (largura_linhas > 0 AND largura_colunas > 0)
);

CREATE TABLE celula (
    id_planilha INT NOT NULL REFERENCES planilha(id_documento),
    linha CHAR(1) NOT NULL,
    coluna CHAR(1) NOT NULL,
    conteudo TEXT NOT NULL,
    cor VARCHAR(7) NOT NULL
        CHECK (cor ~ '^#[0-9a-fA-F]{6}$') DEFAULT '#ffffff', /* Cor hexadecimal */ 
    PRIMARY KEY (id_planilha, linha, coluna)
);

CREATE TYPE FONTE AS ENUM (
    'ARIAL',
    'TIMES_NEW_ROMAN',
    'COURIER_NEW'
);

CREATE TABLE documento_texto (
    id_documento INT PRIMARY KEY REFERENCES documento(id),
    fonte FONTE NOT NULL,
    tamanho_fonte INT NOT NULL CHECK (tamanho_fonte > 0)
);

CREATE TABLE bloco_texto (
    id SERIAL PRIMARY KEY,
    id_documento_texto INT NOT NULL REFERENCES documento_texto(id_documento),
    titulo VARCHAR(255) NOT NULL,
    conteudo TEXT NOT NULL
);

CREATE TABLE formulario (
    id_documento INT PRIMARY KEY REFERENCES documento(id),
    data_limite DATE NOT NULL
);

CREATE TABLE pergunta (
    id SERIAL PRIMARY KEY,
    id_formulario INT NOT NULL REFERENCES formulario(id_documento),
    conteudo VARCHAR(255) NOT NULL
);

CREATE TABLE resposta (
    id SERIAL PRIMARY KEY,
    id_pergunta INT NOT NULL REFERENCES pergunta(id),
    id_usuario INT NOT NULL REFERENCES usuario(id),
    conteudo VARCHAR(255) NOT NULL
);

CREATE TABLE apresentacao (
    id_documento INT PRIMARY KEY REFERENCES documento(id),
    objetivo VARCHAR(255) NOT NULL
);

CREATE TABLE slide (
    id SERIAL PRIMARY KEY,
    id_apresentacao INT NOT NULL REFERENCES apresentacao(id_documento),
    titulo VARCHAR(255) NOT NULL,
    subtitulo VARCHAR(255),
    imagem VARCHAR(2048), /* URL da imagem */
    conteudo TEXT NOT NULL
);