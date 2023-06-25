EXPLAIN (COSTS, VERBOSE, BUFFERS, FORMAT JSON)
SELECT
    d.id,
    d.tipo,
    d.nome,
    d.descricao
FROM documento d
INNER JOIN usuario u ON d.id_dono = u.id
LEFT JOIN planilha p ON p.id_documento = d.id
LEFT JOIN formulario f ON f.id_documento = d.id
LEFT JOIN documento_texto dt ON dt.id_documento = d.id
LEFT JOIN apresentacao a ON a.id_documento = d.id
WHERE u.email = 'willian@email.com'
    AND p.id_documento IS NULL
    AND f.id_documento IS NULL
    AND dt.id_documento IS NULL
    AND a.id_documento IS NULL;