# Requisitos

## Item A1 (Atributo composto)

```sql
CREATE TYPE Info AS (
    nome VARCHAR(50),
    descricao VARCHAR(100),
    data_criacao DATE
);
```

Múltiplos elementos dos documentos necessitam de um mesmo tipo de dado, que é um
conjunto de informações sobre aquele elemento, como nome, descrição e data de
criação.

## Item A2 (Atributo multivalorado)

```sql
ALTER TABLE pergunta ADD COLUMN respostas TEXT[];
```

Aqui, adicionamos um campo respostas do tipo array de textos à tabela pergunta.
A tabela resposta poderia ser excluída, porém deixamos ela para mantermos a
semântica das consultas da parte 1 válidas. Com isso, podemos armazenar as
respostas de uma pergunta em um único campo, sem a necessidade de criar uma
tabela para isso. Assim não precisamos fazer joins para recuperar as respostas
de uma pergunta.

## Item A3 (Herança)

```sql
CREATE TABLE documento_drive (
    id SERIAL PRIMARY KEY,
    info Info,
    id_dono INT NOT NULL REFERENCES usuario(id)
);

CREATE TABLE planilha_drive (
    largura_linhas INT NOT NULL,
    largura_colunas INT NOT NULL
) INHERITS (documento_drive);
```

Criamos a tabela documento_drive, que no fundo é igual à tabela documento,
porém, com o atributos composto info, além de que é utilizada para criarmos a
herança. A tabela planilha_drive é uma tabela que herda de documento_drive,
indicando que ela é um tipo de documento que o usuário poderá criar. Nas
entregas anteriores, eu utilizei uma chave estrangeira na tabela planilha
referenciando a tabela documento, para simular uma herança sem utilizar o
INHERITS. Além disso, não precisamos mais do atributo tipo_documento na tabela
documento_drive, pois a herança já indica o seu tipo. Esse processo de herança
pode ser feito para todos os outros tipos de documento existentes no sistema
(formulário, documento de texto e apresentação).
