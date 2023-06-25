/**
 * Consulta original
 */
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

/**
 * Consulta refeita
 */
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
