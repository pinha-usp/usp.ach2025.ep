# Casos de teste

## Teste 1

Inserir um formulário com data limite ultrapassada e verificar se o gatilho
funciona corretamente quando tentamos inserir uma resposta a uma pergunta desse
formulário.

```sql
INSERT INTO formulario (id_documento, data_limite) VALUES
(1, '2019-01-01');

INSERT INTO pergunta (id, id_formulario, conteudo) VALUES
(1, 1, 'Pergunta 1?');

-- A data limite é 2019-01-01, então a resposta abaixo não deveria ser aceita
INSERT INTO resposta (id_pergunta, id_usuario, conteudo) VALUES
(1, 1, 'Resposta 1');
```

O teste irá lançar uma exceção dizendo que o formulário não aceita mais respostas.

## Teste 2

Inserir um formulário com data limite futura e verificar se o gatilho funciona
corretamente quando tentamos inserir uma resposta a uma pergunta desse formulário.

```sql
INSERT INTO formulario (id_documento, data_limite) VALUES
(2, '2030-01-01');

INSERT INTO pergunta (id, id_formulario, conteudo) VALUES
(2, 2, 'Pergunta 2?');

-- A data limite é 2030-01-01, então a resposta abaixo deveria ser aceita
INSERT INTO resposta (id_pergunta, id_usuario, conteudo) VALUES
(2, 1, 'Resposta 2');
```

O teste irá inserir a resposta sem problemas.

## Teste 3

Inserir diversos novos documentos e verificar se as suas instâncias correspondentes
nas tabelas de tipo de documento (planilha, formulário, etc...) foram criadas

```sql
INSERT INTO documento (id, tipo) VALUES
(3, 'FORMULARIO'),
(4, 'APRESENTACAO'),
(5, 'PLANILHA'),
(6, 'DOCUMENTO');
```

O teste irá inserir os documentos e suas respectivas instâncias nas tabelas de
tipo de documento, além de escrever uma mensagem de sucesso no console para cada
inserção.
