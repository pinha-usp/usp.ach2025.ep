# Explicação do código SQL

```sql
CREATE VIEW documentos_usuarios AS
SELECT
    u.id as id_usuario,
    u.nome as nome_usuario,
    d.id as id_documento,
    d.nome as nome_documento,
    d.descricao as descricao_documento,
    d.data_criacao as data_criacao_documento,
    COUNT(c.id_usuario) as numero_contribuidores
FROM usuario u
JOIN documento d ON u.id = d.id_dono
JOIN contribuicao c ON d.id = c.id_documento
GROUP BY u.id, d.id;
```

O código acima cria uma visão que contém colunas de interesse de usuários e
seus respectivos documentos, além de uma coluna que contém o número de
contribuidores de cada documento. Essa visão engloba o relacionamento de 3
tabelas (usuario, documento, contribuicao).

Filtrando as informações de usuário, aumentos a segurança do sistema, já que
o risco de vazamento de informações é menor, já que as consultas serão feitas
a partir dessa visão e não diretamente na tabela de usuários.
