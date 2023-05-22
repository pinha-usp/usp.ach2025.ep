# Explicação do código SQL

```sql
CREATE VIEW atividades_amizades_fatima AS
WITH amigos_usuario AS (
    SELECT
        u.id,
        u.nome
    FROM usuario u
    INNER JOIN amizade a ON u.id = a.id_remetente OR u.id = a.id_destinatario
    INNER JOIN usuario u2 ON
        (u.id = a.id_remetente AND u2.id = a.id_destinatario) OR
        (u.id = a.id_destinatario AND u2.id = a.id_remetente)
    WHERE u2.email = 'fatima@email.com'
)
SELECT
    d.id,
    d.nome,
    d.descricao,
    d.data_criacao,
    a.nome AS nome_amigo
FROM documento d
INNER JOIN amigos_usuario a ON d.id_dono = a.id
WHERE d.data_criacao >= NOW() - INTERVAL '1 week'
ORDER BY d.data_criacao DESC;
```

O código acima cria uma visão que obtém todos os documentos criados por amigos
do usuário com email "fatima@email.com" na última semana.

Criamos uma tabela temporária com `WITH` que contém todas as amizades de fátima.
Após isso, selecionamos os documentos que foram criados na última semana por essas
mesmas amizades.
