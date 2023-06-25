EXPLAIN (COSTS, VERBOSE, BUFFERS, FORMAT JSON)
SELECT
    d.id,
    d.nome,
    d.descricao,
    d.data_criacao,
    a.nome AS nome_amigo
FROM documento d
INNER JOIN (
    SELECT
        u.id,
        u.nome
    FROM usuario u
    INNER JOIN amizade a ON u.id = a.id_remetente OR u.id = a.id_destinatario
    INNER JOIN usuario u2 ON
        (u.id = a.id_remetente AND u2.id = a.id_destinatario) OR
        (u.id = a.id_destinatario AND u2.id = a.id_remetente)
    WHERE u2.email = 'fatima@email.com'
) AS a ON d.id_dono = a.id
WHERE d.data_criacao >= NOW() - INTERVAL '1 week'
ORDER BY d.data_criacao DESC;

EXPLAIN (COSTS, VERBOSE, BUFFERS, FORMAT JSON)
SELECT
    d.id,
    d.nome,
    d.descricao,
    d.data_criacao,
    u.nome AS nome_amigo
FROM documento d
INNER JOIN usuario u ON d.id_dono = u.id
INNER JOIN amizade a ON
    (u.id = a.id_remetente OR u.id = a.id_destinatario) AND 
    (u.id = a.id_remetente OR u.id = a.id_destinatario)
INNER JOIN usuario u2 ON
    (u.id = a.id_remetente AND u2.id = a.id_destinatario) OR
    (u.id = a.id_destinatario AND u2.id = a.id_remetente)
WHERE
    u2.email = 'fatima@email.com' AND
    d.data_criacao >= NOW() - INTERVAL '1 week'
ORDER BY d.data_criacao DESC;
