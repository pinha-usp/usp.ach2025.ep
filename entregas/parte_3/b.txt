EXPLAIN (COSTS, VERBOSE, BUFFERS, FORMAT JSON)
SELECT
    d.id,
    d.tipo,
    d.nome,
    d.descricao,
    COUNT(c.id_documento) AS numero_contribuidores
FROM documento d
INNER JOIN usuario u ON u.id = d.id_dono
LEFT JOIN contribuicao c ON d.id = c.id_documento
WHERE u.email = 'willian@email.com'
GROUP BY d.id;

EXPLAIN (COSTS, VERBOSE, BUFFERS, FORMAT JSON)
SELECT
    f.id_documento,
    f.data_limite,
    COUNT(DISTINCT r.id_usuario) as numero_respostas
FROM formulario f
INNER JOIN documento d ON f.id_documento = d.id
INNER JOIN usuario u ON d.id_dono = u.id
LEFT JOIN pergunta p ON f.id_documento = p.id_formulario
LEFT JOIN resposta r ON p.id = r.id_pergunta
WHERE u.email = 'luciano@email.com'
GROUP BY f.id_documento;

EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON)
SELECT
    d.id,
    d.tipo,
    d.nome,
    d.descricao
FROM documento d
INNER JOIN usuario u ON d.id_dono = u.id
WHERE u.email = 'willian@email.com' 
AND NOT EXISTS (
    SELECT 1
    FROM planilha p
    WHERE p.id_documento = d.id 
) AND NOT EXISTS (
    SELECT 1
    FROM formulario f
    WHERE f.id_documento = d.id
) AND NOT EXISTS (
    SELECT 1
    FROM documento_texto dt
    WHERE dt.id_documento = d.id
) AND NOT EXISTS (
    SELECT 1
    FROM apresentacao a
    WHERE a.id_documento = d.id
);

EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON)
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